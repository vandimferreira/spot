$(document).ready(function(){
	$("#eventometro").load("/dev/charts/eventometrodnt")
/*
	$("#atb").load("/dev/charts/atb")
	$("#economia").load("/dev/charts/economia")
	$("#novoIframe").load("/dev/charts/eventometrodnt")
	$("#novoIframe2").load("/dev/demandas")
	$("#divVideo").load("/dev/video")
	$("#flow").load("/dev/charts/flow")
	$('#notifybox').load("/dev/notify");
	$('#notifyboxbig').load("/dev/notify");
*/
});

window.addEventListener("scroll", function(event) {
  
    var top = this.scrollY,
        left = this.scrollX;

    //console.log("Position: " +top)

    if (top >= 740) {
    	if (!$("nav").hasClass("nav_solid")){
    		$("nav").addClass("nav_solid");
    	}
    	if ($("nav").hasClass("nav_degrade")){
    		$("nav").removeClass("nav_degrade");
    	}
    	document.getElementById("nav_large").style.height = "80px";
    	document.getElementById("img_logo").style.marginTop = "40px";
    } else if (top < 740) {
    	if ($("nav").hasClass("nav_solid")){
    		$("nav").removeClass("nav_solid");
    	}
    	if (!$("nav").hasClass("nav_degrade")){
    		$("nav").addClass("nav_degrade");
    	}
    	document.getElementById("nav_large").style.height = "150px";
    	document.getElementById("img_logo").style.marginTop = "80px";
      /*  document.getElementsByClassName("black")[0].style.opacity=0;
        document.getElementsByClassName("white")[0].style.opacity=1;*/
    }
    
  
}, false);

function scrollScreen(div){
	$("#"+div).scroll();
	$('html, body').animate({scrollTop: $("#"+div).offset().top}, 2000);
}

function abreGrafico(id){
	switch (id) {
		case 1:
			$("#portalMobileContent").load("https://cesuplicitacoes.intranet.bb.com.br/disec/relatorios")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 2:
			$("#portalMobileContent").load("https://cesuplicitacoes.intranet.bb.com.br/ctr/home")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			document.getElementById("divVoltar").onclick = function() { fechaConteudo(); };
			break;
		case 3:
			$("#portalMobileContent").load("https://disec6.intranet.bb.com.br/fluxotrb/")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 4:
			$("#portalMobileContent").load("https://correioweb.bb.com.br/")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 5:
			$("#portalMobileContent").load("https://cesuplicitacoes.intranet.bb.com.br/priorizado/eventos/solicitarpriorizacao")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			document.getElementById("divVoltar").onclick = function() { fechaConteudo(); };
			break;
		case 6:
			$("#portalMobileContent").load("https://ponto.bb.com.br")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 7:
			$("#portalMobileContent").load("https://cesuplicitacoes.intranet.bb.com.br/#aniversario")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 8:
			$("#portalMobileContent").load("https://www.unibb.com.br")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			document.getElementById("divVoltar").onclick = function() { fechaConteudo(); };
			break;
		case 9:
			$("#portalMobileContent").load("https://digov2.intranet.bb.com.br/RDMNew/")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
		case 10:
			$("#portalMobileContent").load("https://cesuplicitacoes.intranet.bb.com.br/gnt/")
			$('html, body').animate({scrollTop: $("#portalMobile").offset().top}, 2000);
			break;
	}
	document.getElementById("portalMobile").style.display = "block";
}

function fechaConteudo(){
	$('html, body').animate({scrollTop: $("#mainMobile").offset().top}, 2000);
	$("#portalMobileContent").load("/dev/loader")
	//document.getElementById("closeMobile").style.display = "none";
	document.getElementById("portalMobile").style.display = "none";
}

function abreNoticiasPortalAntigo(id){
	$("#contentNoticiasBig").load("/dev/noticia?id="+id);
	document.getElementById("idLikeNoticia").value = id;
	$("#modal1").modal('open');
}

function fechaNoticias(){
	$("#modal1").modal('close');
}

function mostraNoticias(id){
	$("#portalMobileContent").load("/dev/noticia?id="+id);
	document.getElementById("divVoltar").onclick = function() { abreGrafico(2); };

}

function curtirNoticias(){
	id = document.getElementById("idLikeNoticia").value;
	$.ajax({
		url:"/dev/curtirnoticias", 
		type:"POST", 
		data:{"id":id}, 
		success:function(data){
			//alert("Resposta Ajax: " + data)
		}
	});
}

function navegaAnterior(){
	$('.slider').slider('prev');
}

function navegaPosterior(){
	$('.slider').slider('next');
}