function limitText(limitField, limitCount, limitNum) {
if (limitField.value.length > limitNum) {
    limitField.value = limitField.value.substring(0, limitNum);
    alert('Максимальна кількість символів - '+(limitNum));
}
else {
	limitCount.value = limitNum - limitField.value.length; 
} 
}

function validates(){
    reg = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/;


    if ((document.forms[0].elements["_03ce8785bca32cd77bfe5dd12e9a1668"].value.length<=2) || (document.forms[0].elements["_03ce8785bca32cd77bfe5dd12e9a1668"].value)=='ПІБ')  {
        alert('Неприпустиме значення: "ПІБ"');
        return false;
    }

    if ((document.forms[0].elements["_1b6adf603d36dec6296147ed261818cc"].value.length<=5) || (document.forms[0].elements["_1b6adf603d36dec6296147ed261818cc"].value)=='Електронна пошта' || (!document.forms[0].elements["_1b6adf603d36dec6296147ed261818cc"].value.match(reg))){
        alert('Неприпустиме значення: "Електронна пошта"');
        return false;
    }

   if ((document.forms[0].elements["_96466ef0f6a233b0201bac50211347d4"].value.length==0) || (document.forms[0].elements["_96466ef0f6a233b0201bac50211347d4"].value)=='Тема листа')  {
        alert('Неприпустиме значення: "Тема листа"');
        return false;
    }
    if (document.forms[0].elements["_88e32ee7699de18490856da18de5c83c"].value.length<=15){
        alert('Надто короткий текст листа');
        return false;
    }
}