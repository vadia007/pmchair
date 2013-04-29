function InitializeDropdowns()
{
	//get all the select fields on the page
	dropdowns = document.getElementsByTagName('select');
	//cycle trough the select fields
	for (var i = 0; i < dropdowns.length; ++i)
	{
		//check if the input is a dropdown
		//if (dropdowns[i].getAttribute('class') == 'fox_dropdown')
		if (strpos(dropdowns[i].getAttribute('class'), 'fox_dropdown', 0) !== false)
			{
			DropdownSetStyle(dropdowns[i]);
			DropdownAlignValue(dropdowns[i]);
		}
	}

	//get all the select fields on the page
	spans = document.getElementsByTagName('span');
	//cycle trough the select fields
	for (var i = 0; i < spans.length; ++i)
	{
		//check if the input is a checkbox
		//if (spans[i].getAttribute('class') == 'outer_dropdown')
		if (strpos(spans[i].getAttribute('class'), 'outer_dropdown', 0) !== false)
			{
			SpanSetStyle(spans[i]);
		}
	}
}


function DropdownAlignValue(dropdown)
{
	var span = document.getElementById('ddi' + dropdown.name);  // ddi_1234567890
	var text = dropdown.options[dropdown.selectedIndex].text;
	//if (!text) text = '&#160;';

	if (document.all)
		{
		// IE
		span.innerText = text;
	}
	else
		{
		// Firefox
		// http://stackoverflow.com/questions/1359469/innertext-works-in-ie-but-not-in-firefox
		// http://blog.coderlab.us/2005/09/22/using-the-innertext-property-with-firefox/
		span.textContent = text;
	}
}


function DropdownSetStyle(dropdown)
{
	dropdown.style.opacity = '0';  // Hide the real dropdown
	dropdown.style.position = 'absolute';  // Overlap it to the related span
	dropdown.style.height = '28px';  // Set the height to fit related span

	// To work on damned IE http://joseph.randomnetworks.com/2006/08/16/css-opacity-in-internet-explorer-ie/
	if (document.all)
		{
		// IE
		dropdown.style.filter = 'alpha(opacity = 0)';
		dropdown.style.zoom = '1';
	}
}


function SpanSetStyle(span)
{
	// span.style.display = 'inline-block';  // Make it visible
	span.style.display = 'table';  // Make it visible
}


function strpos(haystack, needle, offset)
{
	var i = (haystack + '').indexOf(needle, (offset || 0));
	return i === -1 ? false : i;
}

function ResetFoxControls()
{
	ResetCheckboxes();
	ResetDropdowns();
}

function ResetCheckboxes()
{
	//get all the input fields on the page
	inputs = document.getElementsByTagName('input');
	//cycle trough the input fields
	for (var i = 0; i < inputs.length; ++i)
	{
		//check if the input is a checkbox
		if (inputs[i].getAttribute('type') == 'checkbox' && inputs[i].getAttribute('class') == 'foxcheckbox')
			{
			var id = inputs[i].getAttribute('name');
			var span = document.getElementById('s' + id);
			span.className = 'fox_cbspan fox_cbspan_false';
		}
	}
}

function ResetDropdowns()
{
	//get all the select fields on the page
	dropdowns = document.getElementsByTagName('select');
	//cycle trough the select fields
	for (var i = 0; i < dropdowns.length; ++i)
	{
		//check if the input is a dropdown
		if (strpos(dropdowns[i].getAttribute('class'), 'fox_dropdown', 0) !== false)
			{
			var span = document.getElementById('ddi' + dropdowns[i].name);
			if (document.all)
				{
				// IE
				span.innerText = '';
			}
			else
				{
				// Firefox
				// http://stackoverflow.com/questions/1359469/innertext-works-in-ie-but-not-in-firefox
				// http://blog.coderlab.us/2005/09/22/using-the-innertext-property-with-firefox/
				span.textContent = '';
			}
		}
	}
}
