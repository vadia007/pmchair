<?php
/**
 * Element: MultiSelect
 * Displays a multiselectbox
 *
 * @package         NoNumber Framework
 * @version         12.11.6
 *
 * @author          Peter van Westen <peter@nonumber.nl>
 * @link            http://www.nonumber.nl
 * @copyright       Copyright © 2012 NoNumber All Rights Reserved
 * @license         http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die;

/**
 * MultiSelect Element
 */
class JFormFieldNN_MultiSelect extends JFormField
{
	public $type = 'MultiSelect';

	protected function getInput()
	{
		$this->params = $this->element->attributes();

		if (!is_array($this->value)) {
			$this->value = explode(',', $this->value);
		}

		foreach ($this->element->children() as $item) {
			$item_value = (string) $item['value'];
			$item_name = JText::_(trim((string) $item));
			$item_disabled = (int) $item['disabled'];
			$options[] = JHtml::_('select.option', $item_value, $item_name, 'value', 'text', $item_disabled);
		}

		$size = (int) $this->def('size');

		require_once JPATH_PLUGINS . '/system/nnframework/helpers/html.php';
		return nnHTML::selectlist($options, $this->name, $this->value, $this->id, $size, 1);
	}

	private function def($val, $default = '')
	{
		return (isset($this->params[$val]) && (string) $this->params[$val] != '') ? (string) $this->params[$val] : $default;
	}
}
