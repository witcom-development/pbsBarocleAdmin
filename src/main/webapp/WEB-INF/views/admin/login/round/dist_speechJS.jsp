<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>

<script type="text/javascript">

var speech = {};

function startSpeech(){
	speech.recognition.start();
}

function initSpeech(){
 
	 if ('webkitSpeechRecognition' in window) {

		speech.recognition = new webkitSpeechRecognition();
		
		speech.recognition.interimResults = true;
		speech.recognition.lang = 'ko-KR';
		
		let makeNewTextContent = function() {
		    p = document.createElement('p');
		    texts = "";
		    document.querySelector('#speechTest').appendChild(p);
		  };
	
		  let p = null;
		  let texts = null; 
	
		  speech.recognition.onstart = function() {
		    makeNewTextContent(); // 음성 인식 시작시마다 새로운 문단을 추가한다.
		  };
		  speech.recognition.onend = function() {
			  speech.recognition.start();
		  };
	
		  speech.recognition.onresult = function(e) {
			  
		    for( var i = e.resultIndex; i < e.results.length; ++i){
				
		    	texts = e.results[i][0].transcript;
		    	
				if(e.results[i].isFinal){
					//마지막
				}    	
				
		    }
		    
		    texts.replace(/느낌표|강조|뿅/gi, '❗️');
			
		    console.log(texts);
		    
		    p.textContent = texts;
	    
	  };
	  
	 }

}

</script>
</body>
</html>