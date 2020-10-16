$(document).ready(function(){

	$('.link_remove_slide').click(function(){
		$('#'+$(this).data('id')).remove();
		return false;
	})

	$('.inactive').click(function(){
		return false;
	})

	$('.datepicker').datepicker({language: 'pl',  format: 'yyyy-mm-dd'});

})

$(document).on('click', '.open_roxy', function(){
	$('.roxy_target').removeClass('roxy_target');
	$(this).find('img').addClass('roxy_target');
	$('#roxySelectFile').modal('show').find('iframe').attr("src",'js/ckeditor/fileman/index.html?integration=custom');
	return false;
})

$(document).on('hidden.bs.modal', '.modal', function () {
    $('.modal:visible').length && $(document.body).addClass('modal-open');
});

function closeRoxySelectFile(){
	$roxy_target = $('.roxy_target');
	$("[name='"+$roxy_target.data('roxy_name')+"']").val($roxy_target.attr('src'));
	$('#roxySelectFile').modal('hide');
}

function run_ckeditor(id,height=200){
	var roxyFileman = 'js/ckeditor/fileman/index.html';
	$(function(){
		CKEDITOR.replace( id,{height: height,
			filebrowserBrowseUrl:roxyFileman,
			filebrowserImageBrowseUrl:roxyFileman+'?type=image',
			removeDialogTabs: 'link:upload;image:upload'});
	});
}
