<?php
/**
 * The Template for displaying all single posts.
 *
 * @package focus
 * @since focus 1.0
 */

get_header(); the_post(); ?>

<a name="wrapper"></a>
<div id="primary" class="content-area">


 	<div id="single-header">
		<div class="overlay"></div>
	<!--

 		 <?php if(has_post_thumbnail()) : ?>
 			
				<?php the_post_thumbnail('slider') ?>
			
	
		<?php endif; ?>
		-->
		<?php if( siteorigin_setting( 'icons_post_navigation' ) ) : ?>
			<?php focus_navigation_arrows(); ?>
		<?php endif; ?>

		<div class="container">
			<div class="post-heading">
				<?php focus_display_icon( 'icons_post_previous' ); ?>
				<h1><?php the_title() ?></h1>
				<?php if(has_excerpt()) : ?><p><?php the_excerpt() ?></p><?php endif; ?>
			</div>
					<?php the_content() ?>
			<?php if(focus_post_has_video()) : ?>
				<div class="video">
					<?php focus_post_video() ?>
				</div>
			<?php endif; ?>

			<?php if( siteorigin_setting( 'icons_post_navigation' ) ) : ?>
				<div class="nav-arrow-links">
					<?php focus_navigation_arrows(); ?>
				</div>
			<?php endif; ?>
		</div>
	</div>
	


	