/**
 * Javascript file
 *
 * @package         Sourcerer
 * @version         4.0.1
 *
 * @author          Peter van Westen <peter@nonumber.nl>
 * @link            http://www.nonumber.nl
 * @copyright       Copyright © 2012 NoNumber All Rights Reserved
 * @license         http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

sourcerer_init = function()
{
	// define variables used in function
	var iframes, editor_frame, contentWindow, selection, string, button;
	var editor_textarea = window.parent.document.getElementById(sourcerer_editorname);

	// Find and handle selected text
	if (editor_textarea) {
		iframes = editor_textarea.parentNode.getElementsByTagName('iframe');
		if (!iframes.length) {
			return;
		}

		editor_frame = iframes[0];
		contentWindow = editor_frame.contentWindow;

		selection = '';
		if (contentWindow.getSelection) {
			selection = contentWindow.getSelection().toString().trim();
		} else {
			selection = contentWindow.document.selection.createRange().htmlText;
			selection = sourcerer_cleanRange(selection);
		}

		if (selection != '') {
			editAreaLoader.setValue('source', selection);
		}
	}

	string = editAreaLoader.getValue('source');

	// Handle indentation
	string = string.replace(/^ {4}/gm, '\t');

	editAreaLoader.setValue('source', string);

	// Init Source Tags button
	button = document.getElement('#sourcetags_button');
	if (string.search('{' + sourcerer_syntax_word) != -1) {
		button.addClass('btn-nosourcetags');
	}
	if (sourcerer_default_addsourcetags) {
		sourcerer_toggleSourceTags(1);
	}

	// Init Tag Style button
	button = document.getElement('#tagstyle_button');
	if (string.search(/\[\[/g) != -1 && string.search(/\]\]/g) != -1) {
		buttonaddClass('btn-tagstylebrackets');
	}
};

sourcerer_insertText = function()
{
	// define variables used in function
	var spans, regex;
	var string = sourcerer_loadSyntax('php', 0);

	if (string.length) {
		// remove spans in {source} tags
		spans = '(?:<span(?: [^>]*)?>|</span>)*';
		regex = new RegExp('(\{)' + spans + '(/?)' + spans + '(' + sourcerer_syntax_word + '(?: [^\}]*)?)' + spans + '(\})', 'gm');
		string = string.replace(regex, '$1$2$3$4');
	} else {
		string = editAreaLoader.getValue('source');
		string = htmlentities(string);
	}

	string = sourcerer_insertBreaks(string);
	string = sourcerer_protectIndent(string);

	// Set all code (with {source} tags) in courier
	regex = new RegExp('(?:<span(?: [^>]*)?>\s*)*(\{' + sourcerer_syntax_word + '(?: [^\}]*)?\})(?:\s*</span>\)*', 'gim');
	string = string.replace(regex, '$1<span style="font-family: courier new, courier, monospace;">');
	regex = new RegExp('(?:<span(?: [^>]*)?>\s*)*(\{/' + sourcerer_syntax_word + '\})(?:\s*</span>\)*', 'gim');
	string = string.replace(regex, '</span>$1');

	// remove any leftover linebreaks
	regex = new RegExp('[\n\r]', 'gm');
	string = string.replace(regex, '');

	window.parent.jInsertEditorText(string, sourcerer_editorname);
	if (typeof( window.parent['tinyMCE'] ) != "undefined") {
		var ed = window.parent.tinyMCE.get(sourcerer_editorname);
		if (ed) {
			ed.hide();
			window.parent.setTimeout(function() {
				ed.show();
			}, 5);
		}
	}
};

sourcerer_protectIndent = function(string)
{
	// define variables used in function
	var regex;

	regex = new RegExp('    ', 'g');
	string = string.replace(regex, '\t');
	regex = new RegExp('^[ ]{1,3}([^ ])', 'gm');
	string = string.replace(regex, '\n\t$1');
	regex = new RegExp('^((-src_spacer-)*)\t', 'gm');
	while (string.search(regex) != -1) {
		string = string.replace(regex, '$1-src_spacer-');
	}
	regex = new RegExp('-src_spacer-', 'g');
	string = string.replace(regex, '<img src="' + sourcerer_root + '/plugins/editors-xtd/sourcerer/images/tab.png" alt="&nbsp;&nbsp;&nbsp;&nbsp;" />');

	return string;
};

sourcerer_toggleSourceTags = function(add)
{
	// define variables used in function
	var regex;
	var button = document.getElement('#sourcetags_button');
	var string = editAreaLoader.getValue('source');

	regex = new RegExp(preg_quote('{' + sourcerer_syntax_word + '}') + '\\s*', 'gim');
	string = string.replace(regex, '');
	regex = new RegExp('\\s*' + preg_quote('{/' + sourcerer_syntax_word + '}'), 'gim');
	string = string.replace(regex, '');

	if (!add && !button.hasClass('btn-nosourcetags')) {
		button.addClass('btn-nosourcetags');
	} else {
		string = '{' + sourcerer_syntax_word + '}\n' + string + '\n' + '{/' + sourcerer_syntax_word + '}';
		button.removeClass('btn-nosourcetags');
	}

	editAreaLoader.setValue('source', string);
};

sourcerer_toggleTagStyle = function()
{
	// define variables used in function
	var button = document.getElement('#tagstyle_button');
	var string = editAreaLoader.getValue('source');

	string = string.replace(/\[\[/g, '<');
	string = string.replace(/\]\]/g, '>');

	if (!button.hasClass('btn-tagstylebrackets')) {
		string = string.replace(/<(\/?\w+((\s+\w+(\s*=\s*(?:"[\s\S.]*?"|'[\s\S.]*?'|[^'">\s]+))?)+\s*|\s*)\/?(--)?)>/gm, '[[$1]]');
		string = string.replace(/<(!--[\s\S.]*?--)>/gm, '[[$1]]');
		string = string.replace(/<\?(?:php)?([^a-z0-9])/gim, '[[?php$1');
		string = string.replace(/( *)\?>/g, '$1?]]');

		button.addClass('btn-tagstylebrackets');
	} else {
		button.removeClass('btn-tagstylebrackets');
	}

	editAreaLoader.setValue('source', string);
};

sourcerer_trim = function(string)
{
	string = string.replace(/^\s+/g, '');
	string = string.replace(/\s+$/g, '');
	return string.trim();
};

sourcerer_insertBreaks = function(string)
{
	// convert cariage returns to html enters
	string = sourcerer_trim(string);
	string = string.replace(/\n/gm, '<br />\n');

	return sourcerer_trim(string);
};

sourcerer_loadSyntax = function(syntax, is_waiting)
{
	// define variables used in function
	var frame_source, regex, string;

	if (!editAreaLoader.load_syntax[syntax]) {
		if (!is_waiting) {
			load_script(sourcerer_root + '/plugins/editors-xtd/sourcerer/editarea/reg_syntax/' + syntax + ".js");
		}
		setTimeout("sourcerer_loadSyntax( '" + syntax + "', true );", 100);
	} else {
		frame_source = document.getElement('#frame_source');
		string = frame_source.contentWindow.eA.content_highlight.innerHTML;

		// clean IE enters and pre tags
		regex = new RegExp('\r', 'gm');
		string = string.replace(regex, '');
		regex = new RegExp('</?pre>', 'gim');
		string = string.replace(regex, '');

		string = sourcerer_cleanTags(string);

		return string;
	}
};

sourcerer_cleanTags = function(string)
{
	var regex = new RegExp('<span( [^>]*)?>', 'gim');
	string = string.replace(regex, '<span>');
	regex = new RegExp('<span>(&gt;|&lt;)</span>', 'gim');
	string = string.replace(regex, '<XXX>$1</XXX>');
	regex = new RegExp('</?span>', 'gim');
	string = string.replace(regex, '');
	regex = new RegExp('<(/?)XXX>', 'gim');
	string = string.replace(regex, '<$1span>');
	return string;
};

sourcerer_cleanRange = function(string)
{
	var regex = new RegExp('[\n\r]', 'gim');
	string = string.replace(regex, '');
	regex = new RegExp('<img[^>]*alt="    "[^>]*>', 'gim');
	string = string.replace(regex, '    ');
	regex = new RegExp('(</p><p>|<p>|</p>|<br>|<br />)', 'gim');
	string = string.replace(regex, '\n');
	regex = new RegExp('</?[^>]*>', 'gim');
	string = string.replace(regex, '');
	string = string.replace(/^\s+/, '');
	string = string.replace(/\s+$/, '');
	return string;
};

load_script = function(url)
{
	// define variables used in function
	var script, head;

	try {
		script = document.createElement('script');
		script.type = "text/javascript";
		script.src = url;
		script.charset = "UTF-8";
		head = document.getElementsByTagName('head');
		head[0].appendChild(script);
	} catch (e) {
		document.write("<script type='text/javascript' src='" + url + "' charset=\"UTF-8\"><" + "/script>");
	}
};

htmlentities = function(string, quote_style)
{
	// define variables used in function
	var histogram, symbol, tmp_str, entity;

	tmp_str = string.toString();

	if (false === ( histogram = get_html_translation_table('HTML_ENTITIES', quote_style) )) {
		return false;
	}

	for (symbol in histogram) {
		entity = histogram[symbol];
		tmp_str = tmp_str.split(symbol).join(entity);
	}

	return tmp_str;
};

get_html_translation_table = function(table, quote_style)
{
	// define variables used in function
	var entities = {}, histogram = {}, decimal = 0, symbol = '';
	var constMappingTable = {}, constMappingQuoteStyle = {};
	var useTable = {}, useQuoteStyle = {};

	// Translate arguments
	constMappingTable[0] = 'HTML_SPECIALCHARS';
	constMappingTable[1] = 'HTML_ENTITIES';
	constMappingQuoteStyle[0] = 'ENT_NOQUOTES';
	constMappingQuoteStyle[2] = 'ENT_COMPAT';
	constMappingQuoteStyle[3] = 'ENT_QUOTES';

	useTable = !isNaN(table) ? constMappingTable[table] : table ? table.toUpperCase() : 'HTML_SPECIALCHARS';
	useQuoteStyle = !isNaN(quote_style) ? constMappingQuoteStyle[quote_style] : quote_style ? quote_style.toUpperCase() : 'ENT_COMPAT';

	if (useTable !== 'HTML_SPECIALCHARS' && useTable !== 'HTML_ENTITIES') {
		throw Error('Table: ' + useTable + ' not supported');
		// return false;
	}

	// ascii decimals for better compatibility
	entities['38'] = '&amp;';
	if (useQuoteStyle !== 'ENT_NOQUOTES') {
		entities['34'] = '&quot;';
	}
	if (useQuoteStyle === 'ENT_QUOTES') {
		entities['39'] = '&#039;';
	}
	entities['60'] = '&lt;';
	entities['62'] = '&gt;';

	if (useTable === 'HTML_ENTITIES') {
		entities['160'] = '&nbsp;';
		entities['161'] = '&iexcl;';
		entities['162'] = '&cent;';
		entities['163'] = '&pound;';
		entities['164'] = '&curren;';
		entities['165'] = '&yen;';
		entities['166'] = '&brvbar;';
		entities['167'] = '&sect;';
		entities['168'] = '&uml;';
		entities['169'] = '&copy;';
		entities['170'] = '&ordf;';
		entities['171'] = '&laquo;';
		entities['172'] = '&not;';
		entities['173'] = '&shy;';
		entities['174'] = '&reg;';
		entities['175'] = '&macr;';
		entities['176'] = '&deg;';
		entities['177'] = '&plusmn;';
		entities['178'] = '&sup2;';
		entities['179'] = '&sup3;';
		entities['180'] = '&acute;';
		entities['181'] = '&micro;';
		entities['182'] = '&para;';
		entities['183'] = '&middot;';
		entities['184'] = '&cedil;';
		entities['185'] = '&sup1;';
		entities['186'] = '&ordm;';
		entities['187'] = '&raquo;';
		entities['188'] = '&frac14;';
		entities['189'] = '&frac12;';
		entities['190'] = '&frac34;';
		entities['191'] = '&iquest;';
		entities['192'] = '&Agrave;';
		entities['193'] = '&Aacute;';
		entities['194'] = '&Acirc;';
		entities['195'] = '&Atilde;';
		entities['196'] = '&Auml;';
		entities['197'] = '&Aring;';
		entities['198'] = '&AElig;';
		entities['199'] = '&Ccedil;';
		entities['200'] = '&Egrave;';
		entities['201'] = '&Eacute;';
		entities['202'] = '&Ecirc;';
		entities['203'] = '&Euml;';
		entities['204'] = '&Igrave;';
		entities['205'] = '&Iacute;';
		entities['206'] = '&Icirc;';
		entities['207'] = '&Iuml;';
		entities['208'] = '&ETH;';
		entities['209'] = '&Ntilde;';
		entities['210'] = '&Ograve;';
		entities['211'] = '&Oacute;';
		entities['212'] = '&Ocirc;';
		entities['213'] = '&Otilde;';
		entities['214'] = '&Ouml;';
		entities['215'] = '&times;';
		entities['216'] = '&Oslash;';
		entities['217'] = '&Ugrave;';
		entities['218'] = '&Uacute;';
		entities['219'] = '&Ucirc;';
		entities['220'] = '&Uuml;';
		entities['221'] = '&Yacute;';
		entities['222'] = '&THORN;';
		entities['223'] = '&szlig;';
		entities['224'] = '&agrave;';
		entities['225'] = '&aacute;';
		entities['226'] = '&acirc;';
		entities['227'] = '&atilde;';
		entities['228'] = '&auml;';
		entities['229'] = '&aring;';
		entities['230'] = '&aelig;';
		entities['231'] = '&ccedil;';
		entities['232'] = '&egrave;';
		entities['233'] = '&eacute;';
		entities['234'] = '&ecirc;';
		entities['235'] = '&euml;';
		entities['236'] = '&igrave;';
		entities['237'] = '&iacute;';
		entities['238'] = '&icirc;';
		entities['239'] = '&iuml;';
		entities['240'] = '&eth;';
		entities['241'] = '&ntilde;';
		entities['242'] = '&ograve;';
		entities['243'] = '&oacute;';
		entities['244'] = '&ocirc;';
		entities['245'] = '&otilde;';
		entities['246'] = '&ouml;';
		entities['247'] = '&divide;';
		entities['248'] = '&oslash;';
		entities['249'] = '&ugrave;';
		entities['250'] = '&uacute;';
		entities['251'] = '&ucirc;';
		entities['252'] = '&uuml;';
		entities['253'] = '&yacute;';
		entities['254'] = '&thorn;';
		entities['255'] = '&yuml;';
	}

	// ascii decimals to real symbols
	for (decimal in entities) {
		symbol = String.fromCharCode(decimal);
		histogram[symbol] = entities[decimal];
	}

	return histogram;
};

preg_quote = function(str)
{
	return (str + '').replace(/([\\\.\+\*\?\[\^\]\$\(\)\{\}\=\!<>\|\:])/g, '\$1');
};

String.prototype.ltrim = function() { return this.replace(/^ */, ""); };
String.prototype.rtrim = function() { return this.replace(/ *$/, ""); };
String.prototype.trim = function() { return this.ltrim().rtrim(); };
