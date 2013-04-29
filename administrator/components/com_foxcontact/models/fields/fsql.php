<?php defined('JPATH_PLATFORM') or die;

JFormHelper::loadFieldClass('list');

class JFormFieldFSQL extends JFormFieldList
{
	public $type = 'FSQL';

	protected function getOptions()
	{
		// Initialize variables.
		$options = array();

		// Initialize some field attributes.
		$key = $this->element['key_field'] ? (string) $this->element['key_field'] : 'value';
		$value = $this->element['value_field'] ? (string) $this->element['value_field'] : (string) $this->element['name'];
		$query = (string) $this->element['query'];

		// Get the database object.
		$db = JFactory::getDBO();

		// Set the query and get the result list.
		$db->setQuery($query);
		$items = $db->loadObjectlist() or $items = new stdClass();

		foreach ($items as $item)
		{
			$options[] = JHtml::_('select.option', $item->$key, $item->$value);
		}

		// Merge any additional options in the XML definition.
		$options = array_merge(parent::getOptions(), $options);

		return $options;
	}
}
