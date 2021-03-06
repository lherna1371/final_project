$(document).ready(function() {
  (function () {
    var takePicture = document.querySelector("#take-picture"),
      showPicture = document.querySelector("#show-picture");
      
      if (takePicture && showPicture) {
      console.log("getting through two");
      takePicture.onchange = function (event) {
        var files = event.target.files,
          file;
        if (files && files.length > 0) {
          file = files[0];
          try {
            var URL = window.URL || window.webkitURL;

            var imgURL = URL.createObjectURL(file);

            showPicture.src = imgURL;

            URL.revokeObjectURL(imgURL);
          }
          catch (e) {
            try {
              var fileReader = new FileReader();
              fileReader.onload = function (event) {
                showPicture.src = event.target.result;
              };
              fileReader.readAsDataURL(file);
            }
            catch (e) {

              var error = document.querySelector("#error");
              if (error) {
                error.innerHTML = "createObjectURL or FileReader are not working";
              }
            }
          }
        }
      };
    }
  })();
  $('#upload').click(function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.colorbox({width:"99%", height:"99%",  href: url,onComplete:function(){
       function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
                }
            }
    
      $("#take-picture").change(function(){
          readURL(this);
      });
    }});
    $('#save_to_db').submit();
  });
});





