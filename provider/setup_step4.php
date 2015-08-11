<?php
defined('APPHP_EXEC') or die('Restricted Access');
if($objLogin->IsLoggedInAsDoctor()) {
	$images = DoctorImages::GetImagesForDoctor($objLogin -> GetLoggedID());
	$membershipInfo = Doctors::GetMembershipInfo($objLogin -> GetLoggedID());
//	echo var_dump($images);
//	echo var_dump($membershipInfo);
?>

<style type="text/css">
img.provider_photo {
	display: inline;
	width: 160px;
	height: 120px;
	float: none;
}

.btn {
	text-transform: none;
}
</style>

<div class="steps" id="setup_step4">
	<!--Photos-->
		<div class="row">
			<legend>Photo</legend>
			<div class="col-md-4">
				<p><b>Uploaded photo (maximum <?php echo $membershipInfo['images_count']; ?> photo(s))</b></p>
<?php
	foreach($images[0] as $img) {
		echo "<div data-id='{$img['id']}'><img src='images/doctors/{$img['item_file']}' class='provider_photo' /> <button type='button' class='btn btn-danger' data-role='delete-image'>Delete</button></div>";
	}
?>
			</div>
			<div class="col-md-8">
				<p><b>Select a photo from your computer to upload</b></p>
				<form action="" method="POST" id="form-uploadPhoto" enctype="multipart/form-data">
                    <p>Upload an image</p>
                    <input type="file" name="image_upload" />
                    <div class="row buttons">
                        <div data-role="alert-fileUpload"></div>
                        <button class="btn btn-info" type="button" data-role="uploadImage">Upload</button>
                    </div>
				</form>
            </div>
		</div>
	<div class="row buttons pull-right">
		<button class="btn btn-info" data-role="btn-previous" data-step="3">Previous</button>
		<button class="btn btn-warning" type="button" onclick="window.location.href='index.php?provider=home';">Finish</button>
	</div>
</div>

<?php
}
?>