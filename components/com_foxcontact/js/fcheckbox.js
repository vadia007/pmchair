function HideCheckboxes()
	{
	//get all the input fields on the page
	inputs = document.getElementsByTagName('input');
	//cycle trough the input fields
	for (var i = 0; i < inputs.length; ++i)
		{
		//check if the input is a checkbox
		if (inputs[i].getAttribute('type') == 'checkbox' && inputs[i].getAttribute('class') == 'foxcheckbox')
			{
			//HideCheckboxById(inputs[i].getAttribute('name'));
			HideCheckbox(inputs[i]);
			}
		}
	}


function HideCheckbox(box)
	{
	var span = document.getElementById('s' + box.getAttribute('name'));

	if (box.checked)
		{
		span.className = 'fox_cbspan fox_cbspan_true';
		}
	else
		{
		span.className = 'fox_cbspan fox_cbspan_false';
		}

	box.style.display = 'none';
	}


function HideCheckboxById(id)
	{
	var box = document.getElementById('c' + id);
	var span = document.getElementById('s' + id);

	if (box.checked)
		{
		span.className = 'checkbox_true';
		}
	else
		{
		span.className = 'checkbox_false';
		}

	box.style.display = 'none';
	}


function ChangeCheckboxState(id)
	{
	var box = document.getElementById('c' + id);
	var span = document.getElementById('s' + id);

	if (box.checked)
		{
		box.checked = '';
		span.className = 'fox_cbspan fox_cbspan_false';
		}
	else
		{
		box.checked = 'checked';
		span.className = 'fox_cbspan fox_cbspan_true';
		}
	}

