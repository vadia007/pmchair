<?php
/**
 * Code Syntax Highlighting Parameter Element/Field
 * @author gabe@fijiwedesign.com
 * @link http://www.fijiwebdesign.com/
 * @copyright (c) 2010 Fiji Web Design
 */
 
// no direct access
defined('_JEXEC') or die('Restricted access');

class JFormFieldCode extends JFormField
{

  public $type = 'Code';

  protected function getInput()
  {
  
    $html = '
    
    <script type="text/javascript">
      $(window).addEvent("domready", function() {
        
        var element = document.getElementById("' . $this->id . '");
        
        Joomla._submitbutton = Joomla.submitbutton;
        Joomla.submitbutton = function(task) {
          element.value = encodeURIComponent(element.value);
          Joomla._submitbutton(task);      
        };
        element.value = decodeURIComponent(element.value);
      });
    
    
    </script>
    
    
      <textarea id="' . $this->id . '" name="'. $this->name . '" style="width:99%;height:300px;">' . htmlentities($this->value, ENT_QUOTES, 'UTF-8') . '</textarea>
      
    ';
    
  
    return $html;
  }

}