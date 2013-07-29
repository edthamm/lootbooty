
function getHtmlForButton(nameStr, str, bClass,onClickFn){
    if(nameStr == null || nameStr ==""
      || str == null || str ==""
      || onClickFn == null || onClickFn =="") {
        debugMsg("One of the input params for the button is not available");
        return;
    }
    document.writeln('<input type="button" name="',nameStr,'" value="',str,'" class="',bClass,'"  onClick="',onClickFn,'">');
}

function submitAction(){
  if(document.forms[0].err_flag.value == 1){
    // This case occurs when user's attempt to login failed
    // and he is going to login again. This means we have already
    // extracted redirect url in his first attempt and its stored
    // in redirect_url input element. so just submit the form
    document.forms[0].err_flag.value = 0;
    document.forms[0].buttonClicked.value = 4;
    document.forms[0].submit();
  }else{
      var link = document.location.href;
      //alert("Link is "+link);
      var searchString = "?redirect=";
      var equalIndex = link.indexOf(searchString);
      var redirectUrl = "";
      if(equalIndex > 0) {
            equalIndex += searchString.length;
            redirectUrl=link.substring(equalIndex);
            var index=0;
            //add http only if url does not have
            index=redirectUrl.indexOf("http");
            if(index != 0){
               redirectUrl = "http://"+ redirectUrl;
            }
      }
      if(redirectUrl.length > 255){
          redirectUrl = redirectUrl.substring(0,255);
      }
      document.forms[0].redirect_url.value = redirectUrl;
      //alert("redirect url is "+document.forms[0].redirect_url.value);
      document.forms[0].buttonClicked.value = 4;
      document.forms[0].submit();
  }
}

function submitOnEnter(event)
{
  var NS4 = (document.layers) ? true : false;
  var code = 0;
  if (NS4)
	code = event.which;
  else
	code = event.keyCode;
  if (code==13) submitAction(); // 12 corresponds to enter event
}

function checkForMsg(){
    if(document.forms[0].info_flag.value == 1){
        alert(document.forms[0].info_msg.value);
    }
}
