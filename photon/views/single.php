<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Photon &mdash; Colorlib Website Template</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <?php include './loadcssheader.php'?>
  </head>
  <body>
  
  <?php include './header.php'; ?>
  <div class="site-section"  data-aos="fade">
    <div class="container-fluid">
      
      <div class="row justify-content-center">
        
        <div class="col-md-7">
          <div class="row mb-5">
            <div class="col-12 ">
              <h2 class="site-section-heading text-center">Nature Gallery</h2>
            </div>
          </div>
        </div>
    
      </div>
      <div class="row" id="lightgallery">
      <!-- hình ảnh sẽ load từ databse -->
      <!-- tạm 1 hình thôi, chỗ này se load từ database  -->
      <?php for($i=0; $i <= 20; $i++) {?>
        <div class="col-sm-6 col-md-4 col-lg-3 col-xl-2 item" data-aos="fade" data-src="../pulic/images/big-images/nature_big_1.jpg" 
        data-sub-html="<h4>Fading Light</h4>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. 
        Dolor doloremque hic excepturi fugit, sunt impedit fuga tempora, ad amet aliquid?</p>">
          <a href="#"><img src="../public/images/nature_small_1.jpg" alt="IMage" class="img-fluid"></a>
        </div>
      <?php } ?>

      </div>
    </div>
  </div>
  <?php include './footer.php'; ?> 
  </body>
</html>