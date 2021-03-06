<div class="container_comments reviews__text <?php if (isset($settings_widget['number_comments']) && $settings_widget['number_comments'] == '0') { ?> agoo_displaynone <?php } ?>" id="container_comments_<?php echo $mark;?>_<?php echo $mark_id;?>">
<h2>Отзывы:</h2>
<!-- <noindex> -->
<div class="container_comments_vars acc<?php echo $cmswidget; ?>" id="container_comments_vars_<?php echo $mark;?>_<?php echo $mark_id;?>" style="display: none"><div class="mark" data-text="<?php echo $mark; ?>"></div><div class="mark_id" data-text="<?php echo $mark_id; ?>"></div><div class="text_rollup_down" data-text="<?php echo $text_rollup_down; ?>"></div><div class="text_rollup" data-text="<?php echo $text_rollup; ?>"></div><div class="visual_editor" data-text="<?php echo $visual_editor; ?>"></div><div class="sorting" data-text="<?php echo $sorting; ?>"></div><div class="page" data-text="<?php echo $page; ?>"></div><div class="ascp_widgets_position" data-text="<?php echo $ascp_widgets_position; ?>"></div><div class="text_voted_blog_plus" data-text="<?php echo  $text_voted_blog_plus; ?>"></div><div class="text_voted_blog_minus" data-text="<?php echo  $text_voted_blog_minus; ?>"></div><div class="text_all" data-text="<?php echo  $text_all; ?>"></div><div class="prefix" data-text="<?php echo $prefix;?>"></div></div>
<!-- </noindex> -->
<?php if (isset($settings_widget['stat_status']) && $settings_widget['stat_status'] && isset($comments_stat['count_comments']) && $comments_stat['count_comments'] > 0) { include(DIR_TEMPLATE . $comments_stat['template']); } ?>
<?php if (isset($settings_widget['micro_status']) && $settings_widget['micro_status'] && isset($comments_stat['count_ratings']) && $comments_stat['count_ratings'] > 0.1 && isset($product_info['name']) && $product_info['name']!='') { ?>
<span vocab="http://schema.org/" typeof="<?php if (isset($product_info['name']) && $product_info['name']!='') { echo "Product"; } ?>">
<span property="name" content="<?php if (isset($product_info['name']) && $product_info['name']!='') { echo strip_tags(htmlspecialchars($product_info['name'], ENT_COMPAT, 'UTF-8')); } ?>"></span>
<span property="aggregateRating" typeof="AggregateRating">
<span property="ratingValue" min="1" value="<?php echo round($comments_stat['count_ratings_value'] / $comments_stat['count_ratings']); ?>" max="5" content="<?php echo round($comments_stat['count_ratings_value'] / $comments_stat['count_ratings']);?>"></span>
<span property="bestRating" content="5"></span>
<span property="worstRating" content="1"></span>
<span property="ratingCount" content="<?php echo $comments_stat['count_ratings'];?>"></span>
</span>
</span>
<?php } ?>
	<?php
	if (isset($mycomments) && $mycomments) {
	  	if (isset($record_comment['admin_name']) && $record_comment['admin_name']) {
			$admin_name =  array_flip(explode(";",trim($record_comment['admin_name'])));
		}
		$admin = false;
		$opendiv=0;
		foreach ($mycomments as $number => $comment) {
		$opendiv++;
		if (isset($admin_name[trim($comment['author'])]) || (isset($settings_widget['admins']) && in_array($comment['customer_id'], $settings_widget['admins']))) {
		 $back_color = 'background-color: '.$record_comment['admin_color'].';';
		 $admin = true;
		} else {
		 $back_color ='';
		 $admin = false;
		}
	?>
<div id="commentlink_<?php  echo $comment['comment_id']; ?>_<?php  echo $cmswidget; ?>" class="<?php echo $prefix;?>form_customer_pointer comment_content level_<?php  echo $comment['level']; echo ($number < 3) ? " active" : " inactive"; ?>" <?php if (isset($settings_widget['micro_status']) && $settings_widget['micro_status']) { ?>itemprop="review" itemscope itemtype="http://schema.org/Review"<?php } ?>>
<div class="container_comment_vars" id="container_comment_<?php echo $mark;?>_<?php echo $mark_id;?>_<?php echo  $comment['comment_id']; ?>" style="display: none">
<div class="comment_id"><?php echo  $comment['comment_id']; ?></div></div>
<div class="comment_block reviews__item<?php echo ($number == 0) ? " nobord" : ""; ?>">
<p <?php if (isset($settings_widget['micro_status']) && $settings_widget['micro_status']) { ?>itemprop="author"<?php } ?>><b><?php  echo $comment['author']; ?></b>
<?php if (isset($settings_widget['date_status']) && $settings_widget['date_status']) { ?>
<time itemprop="datePublished" datetime="<?php echo $comment['date_added']; ?>"><?php echo $comment['date_added']; ?></time><?php } ?><a style="display:none;" href="<?php echo $url;?>#commentlink_<?php  echo $comment['comment_id']; ?>_<?php  echo $cmswidget; ?>"><?php if (SC_VERSION > 15) { ?><i class="fa fa-link" aria-hidden="true"></i><?php } else { ?>#<?php } ?></a>
</p>
<?php if (isset($settings_widget['rating']) && $settings_widget['rating'] && $comment['rating_mark']==0 ) { ?>
<p> Общая оценка
<span class="reviews__rate">
<?php if (isset($settings_widget['micro_status']) && $settings_widget['micro_status']) { ?>
<meta itemprop="worstRating" content="1" >
<meta itemprop="ratingValue" content="<?php echo $comment['rating']; ?>">
<meta itemprop="bestRating" content="5">
<?php } ?>
<?php if ($theme_stars && !$admin) { 
$star = intval($comment['rating']);
?>

<?php for ($i = 1; $i <= $star; $i++) {?>
<img title="<?php echo $comment['rating']; ?>" alt="<?php echo $comment['rating']; ?>" src="/img/star-yellow.svg">
<?php } 
if ($star < 5){
	$stargr = 5 - $star;
	for ($i = 1; $i <= $stargr; $i++) {?>
		<img title="<?php echo $comment['rating']; ?>" alt="<?php echo $comment['rating']; ?>" src="/img/star-grey.svg">
<?php } } ?>
<?php } ?>
</span>
</p>
<?php } ?>


<?php include(realpath(dirname(__FILE__)).'/../fields_view.tpl'); ?>

<div class="bbcode-text" id="bbcode-text-<?php echo  $comment['comment_id']; ?>">
<span <?php if (isset($settings_widget['micro_status']) && $settings_widget['micro_status']) { ?>itemprop="reviewBody"<?php } ?>><?php echo $comment['text']; ?></span>
</div>

<?php  if (isset($record_comment['karma']) && $record_comment['karma']) { ?>
<div class="voting sc_h_s <?php  if ($comment['customer_delta'] < 0) echo 'voted_blog_minus';  if ($comment['customer_delta'] > 0) echo 'voted_blog_plus';?>"  id="voting_<?php  echo $comment['comment_id']; ?>">
<!-- <noindex> -->
<?php
if (!$comment['customer'] && (isset($settingswidget['karma_reg']) && $settingswidget['karma_reg']==1) ){ ?>
<p class="reviews__useful"><b>Отзыв полезен?</b> 
<a href="#"><?php echo $text_review_yes; ?> <span class="comment_yes blog_plus  voted_comment_plus"></span><?php if ($comment['rate_count_blog_plus']!="0")    { ;?>
<span class="score_plus"><?php  echo $comment['rate_count_blog_plus'];?></span><?php    } else { ?><span class="score_plus"></span><?php  } ?></a> 

<a href="#"><?php echo $text_review_no;  ?> <span></span><?php if ($comment['rate_count_blog_minus']!="0")   { ;?><span class="score_minus"><?php echo $comment['rate_count_blog_minus'];?></span><?php   } else { ?>
<span class="score_minus"></span><?php } ?></a></p>
<?php } else { ?>
<p class="reviews__useful"><b>Отзыв полезен?</b> 

<a href="#blog_plus"  data-cmswidget="<?php echo $cmswidget; ?>" title="<?php echo  $text_vote_blog_plus; ?>"   
class="comment_yes blog_plus comments_vote <?php if (isset($comment['voted']) && $comment['voted']) echo "voted_comment_plus"; ?>" ><?php echo $text_review_yes; ?>
<span class="comments_stat"><?php if ($comment['rate_count_blog_plus']!="0")    { ;?><span class="score_plus"><?php  echo $comment['rate_count_blog_plus'];?></span><?php    } else { ?>
<span class="score_plus"></span><?php  } ?></span></a>

<a href="#blog_minus" data-cmswidget="<?php echo $cmswidget; ?>" title="<?php echo  $text_vote_blog_minus; ?>"  
class="comment_no blog_minus comments_vote <?php if (isset($comment['voted']) && $comment['voted']) echo "voted_comment_minus"; ?>" ><?php echo $text_review_no;  ?>
<span class="comments_stat"><?php if ($comment['rate_count_blog_minus']!="0")   { ;?><span class="score_minus"><?php echo $comment['rate_count_blog_minus'];?></span><?php   } else { ?><span class="score_minus"></span><?php } ?></span></a>
</div>
<?php } ?>

<div style="display:none;" class="mark <?php  if($comment['delta']>=0) {  echo 'positive'; } else {  echo 'negative'; } ?> " >
<span class="text_karma"><?php echo $text_review_karma; ?></span>
<span title="All <?php  echo $comment['rate_count']; ?>: ↑<?php  echo $comment['rate_count_blog_plus']; ?> & ↓<?php  echo $comment['rate_count_blog_minus']; ?>" class="score">
<?php  if($comment['delta']>0) {  echo '+'; } ?><?php  echo sprintf("%d", $comment['delta']); ?>
</span>
</div>
<!-- </noindex> -->
</p>
<?php } ?>
<div id="<?php echo $prefix;?>comment_work_<?php echo $comment['comment_id']; ?>" class="<?php echo $prefix;?>comment_work">
</div>
</div>
<div id="parent<?php echo $comment['comment_id']; ?>" class="comments_parent">
<?php
if ($comment['flag_end']>0) {
if ($comment['flag_end']>$opendiv) {
$comment['flag_end']=$opendiv;
}
for ($i=0; $i<$comment['flag_end']; $i++) {
$opendiv--;
?>
</div>
</div>
<?php
}
}
}
	// for not close div
	if ($opendiv>0 ) {
	for ($i=0; $i<$opendiv; $i++)
	{
	?>
</div>
</div>
<?php
}
}
?>
<!-- <noindex> -->
<div class="overflowhidden" style="display:none">
<div class="floatleft displayinline pagination bordertopnone sc_h_s"><?php echo $pagination; ?></div>
<div class="floatright displayinline sc_h_s form-group">
<select name="sorting" id="sorting_<?php echo $cmswidget; ?>" data-cmswidget="<?php echo $cmswidget; ?>" class="comments_sorting form-control">
<option <?php if ($sorting == 'desc')  echo 'selected="selected"'; ?> data-cmswidget="<?php echo $cmswidget; ?>" value="desc"><?php echo $text_sorting_desc; ?></option>
<option <?php if ($sorting == 'asc')   echo 'selected="selected"'; ?> data-cmswidget="<?php echo $cmswidget; ?>" value="asc"><?php  echo $text_sorting_asc;  ?></option>
</select>
<!-- <label for="sorting_<?php echo $cmswidget; ?>"><?php  echo $entry_sorting; ?></label> -->
</div>
</div>
<!-- </noindex> -->
<?php  }  else { ?>
<!-- <noindex> -->
<div class="sc_h_s">Пока нет комментариев</div>
<!-- </noindex> -->
<?php
}
?>

<?php if (isset($number) && $number >= 3) { $more = $number - 2;?>
<a class="reviews__more">показать ещё отзывы (<?php echo $more; ?>)</a>
<?php } ?>
<button class="reviews__button">Оставить отзыв</button>

</div>
<script>
$(document).ready(function(){
$('.sc_h_s').show();
});
</script>

