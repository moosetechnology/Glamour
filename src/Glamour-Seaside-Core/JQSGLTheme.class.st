Class {
	#name : #JQSGLTheme,
	#superclass : #WAFileLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #uploaded }
JQSGLTheme >> glamourThemeJQueryUICss [
	^ '/*
 * jQuery UI CSS Framework @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Theming/API
 */

/* Layout helpers
----------------------------------*/
.ui-helper-hidden { display: none; }
.ui-helper-hidden-accessible { position: absolute; left: -99999999px; }
.ui-helper-reset { margin: 0; padding: 0; border: 0; outline: 0; line-height: 1.3; text-decoration: none; font-size: 100%; list-style: none; }
.ui-helper-clearfix:after { content: "."; display: block; height: 0; clear: both; visibility: hidden; }
.ui-helper-clearfix { display: inline-block; }
/* required comment for clearfix to work in Opera \*/
* html .ui-helper-clearfix { height:1%; }
.ui-helper-clearfix { display:block; }
/* end clearfix */
.ui-helper-zfix { width: 100%; height: 100%; top: 0; left: 0; position: absolute; opacity: 0; filter:Alpha(Opacity=0); }


/* Interaction Cues
----------------------------------*/
.ui-state-disabled { cursor: default !important; }


/* Icons
----------------------------------*/

/* states and images */
.ui-icon { display: block; text-indent: -99999px; overflow: hidden; background-repeat: no-repeat; }


/* Misc visuals
----------------------------------*/

/* Overlays */
.ui-widget-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }


/*
 * jQuery UI CSS Framework @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Theming/API
 *
 * To view and modify this theme, visit http://jqueryui.com/themeroller/?ffDefault=Verdana,Arial,sans-serif&fwDefault=normal&fsDefault=10pt&cornerRadius=4px&bgColorHeader=dddddd&bgTextureHeader=05_inset_soft.png&bgImgOpacityHeader=75&borderColorHeader=aaaaaa&fcHeader=b5b9c9&iconColorHeader=222222&bgColorContent=ffffff&bgTextureContent=01_flat.png&bgImgOpacityContent=75&borderColorContent=aaaaaa&fcContent=222222&iconColorContent=222222&bgColorDefault=dddddd&bgTextureDefault=05_inset_soft.png&bgImgOpacityDefault=75&borderColorDefault=d3d3d3&fcDefault=000000&iconColorDefault=888888&bgColorHover=ccccca&bgTextureHover=05_inset_soft.png&bgImgOpacityHover=75&borderColorHover=999999&fcHover=000000&iconColorHover=ffffff&bgColorActive=cccccc&bgTextureActive=05_inset_soft.png&bgImgOpacityActive=65&borderColorActive=aaaaaa&fcActive=000000&iconColorActive=ffffff&bgColorHighlight=fbf9ee&bgTextureHighlight=02_glass.png&bgImgOpacityHighlight=55&borderColorHighlight=fcefa1&fcHighlight=363636&iconColorHighlight=2e83ff&bgColorError=fef1ec&bgTextureError=05_inset_soft.png&bgImgOpacityError=95&borderColorError=cd0a0a&fcError=cd0a0a&iconColorError=cd0a0a&bgColorOverlay=aaaaaa&bgTextureOverlay=01_flat.png&bgImgOpacityOverlay=0&opacityOverlay=30&bgColorShadow=aaaaaa&bgTextureShadow=01_flat.png&bgImgOpacityShadow=0&opacityShadow=30&thicknessShadow=8px&offsetTopShadow=-8px&offsetLeftShadow=-8px&cornerRadiusShadow=8px
 */


/* Component containers
----------------------------------*/
.ui-widget { font-family: Verdana,Arial,sans-serif; font-size: 10pt; }
.ui-widget .ui-widget { font-size: 1em; }
.ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button { font-family: Verdana,Arial,sans-serif; font-size: 1em; }
.ui-widget-content { border: 1px solid #aaaaaa; background: #ffffff url(ui-bg_flat_75_ffffff_40x100.png) 50% 50% repeat-x; color: #222222; }
.ui-widget-content a { color: #222222; }
.ui-widget-header { border: 1px solid #aaaaaa; background: #dddddd url(ui-bg_inset-soft_75_dddddd_1x100.png) 50% 50% repeat-x; color: #b5b9c9; font-weight: bold; }
.ui-widget-header a { color: #b5b9c9; }

/* Interaction states
----------------------------------*/
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default { border: 1px solid #d3d3d3; background: #dddddd url(ui-bg_inset-soft_75_dddddd_1x100.png) 50% 50% repeat-x; font-weight: normal; color: #000000; }
.ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited { color: #000000; text-decoration: none; }
.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus { border: 1px solid #999999; background: #ccccca url(ui-bg_inset-soft_75_ccccca_1x100.png) 50% 50% repeat-x; font-weight: normal; color: #000000; }
.ui-state-hover a, .ui-state-hover a:hover { color: #000000; text-decoration: none; }
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active { border: 1px solid #aaaaaa; background: #cccccc url(ui-bg_inset-soft_65_cccccc_1x100.png) 50% 50% repeat-x; font-weight: normal; color: #000000; }
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited { color: #000000; text-decoration: none; }
.ui-widget :active { outline: none; }

/* Interaction Cues
----------------------------------*/
.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight  {border: 1px solid #fcefa1; background: #fbf9ee url(ui-bg_glass_55_fbf9ee_1x400.png) 50% 50% repeat-x; color: #363636; }
.ui-state-highlight a, .ui-widget-content .ui-state-highlight a,.ui-widget-header .ui-state-highlight a { color: #363636; }
.ui-state-error, .ui-widget-content .ui-state-error, .ui-widget-header .ui-state-error {border: 1px solid #cd0a0a; background: #fef1ec url(ui-bg_inset-soft_95_fef1ec_1x100.png) 50% bottom repeat-x; color: #cd0a0a; }
.ui-state-error a, .ui-widget-content .ui-state-error a, .ui-widget-header .ui-state-error a { color: #cd0a0a; }
.ui-state-error-text, .ui-widget-content .ui-state-error-text, .ui-widget-header .ui-state-error-text { color: #cd0a0a; }
.ui-priority-primary, .ui-widget-content .ui-priority-primary, .ui-widget-header .ui-priority-primary { font-weight: bold; }
.ui-priority-secondary, .ui-widget-content .ui-priority-secondary,  .ui-widget-header .ui-priority-secondary { opacity: .7; filter:Alpha(Opacity=70); font-weight: normal; }
.ui-state-disabled, .ui-widget-content .ui-state-disabled, .ui-widget-header .ui-state-disabled { opacity: .35; filter:Alpha(Opacity=35); background-image: none; }

/* Icons
----------------------------------*/

/* states and images */
.ui-icon { width: 16px; height: 16px; background-image: url(ui-icons_222222_256x240.png); }
.ui-widget-content .ui-icon {background-image: url(ui-icons_222222_256x240.png); }
.ui-widget-header .ui-icon {background-image: url(ui-icons_222222_256x240.png); }
.ui-state-default .ui-icon { background-image: url(ui-icons_888888_256x240.png); }
.ui-state-hover .ui-icon, .ui-state-focus .ui-icon {background-image: url(ui-icons_ffffff_256x240.png); }
.ui-state-active .ui-icon {background-image: url(ui-icons_ffffff_256x240.png); }
.ui-state-highlight .ui-icon {background-image: url(ui-icons_2e83ff_256x240.png); }
.ui-state-error .ui-icon, .ui-state-error-text .ui-icon {background-image: url(ui-icons_cd0a0a_256x240.png); }

/* positioning */
.ui-icon-carat-1-n { background-position: 0 0; }
.ui-icon-carat-1-ne { background-position: -16px 0; }
.ui-icon-carat-1-e { background-position: -32px 0; }
.ui-icon-carat-1-se { background-position: -48px 0; }
.ui-icon-carat-1-s { background-position: -64px 0; }
.ui-icon-carat-1-sw { background-position: -80px 0; }
.ui-icon-carat-1-w { background-position: -96px 0; }
.ui-icon-carat-1-nw { background-position: -112px 0; }
.ui-icon-carat-2-n-s { background-position: -128px 0; }
.ui-icon-carat-2-e-w { background-position: -144px 0; }
.ui-icon-triangle-1-n { background-position: 0 -16px; }
.ui-icon-triangle-1-ne { background-position: -16px -16px; }
.ui-icon-triangle-1-e { background-position: -32px -16px; }
.ui-icon-triangle-1-se { background-position: -48px -16px; }
.ui-icon-triangle-1-s { background-position: -64px -16px; }
.ui-icon-triangle-1-sw { background-position: -80px -16px; }
.ui-icon-triangle-1-w { background-position: -96px -16px; }
.ui-icon-triangle-1-nw { background-position: -112px -16px; }
.ui-icon-triangle-2-n-s { background-position: -128px -16px; }
.ui-icon-triangle-2-e-w { background-position: -144px -16px; }
.ui-icon-arrow-1-n { background-position: 0 -32px; }
.ui-icon-arrow-1-ne { background-position: -16px -32px; }
.ui-icon-arrow-1-e { background-position: -32px -32px; }
.ui-icon-arrow-1-se { background-position: -48px -32px; }
.ui-icon-arrow-1-s { background-position: -64px -32px; }
.ui-icon-arrow-1-sw { background-position: -80px -32px; }
.ui-icon-arrow-1-w { background-position: -96px -32px; }
.ui-icon-arrow-1-nw { background-position: -112px -32px; }
.ui-icon-arrow-2-n-s { background-position: -128px -32px; }
.ui-icon-arrow-2-ne-sw { background-position: -144px -32px; }
.ui-icon-arrow-2-e-w { background-position: -160px -32px; }
.ui-icon-arrow-2-se-nw { background-position: -176px -32px; }
.ui-icon-arrowstop-1-n { background-position: -192px -32px; }
.ui-icon-arrowstop-1-e { background-position: -208px -32px; }
.ui-icon-arrowstop-1-s { background-position: -224px -32px; }
.ui-icon-arrowstop-1-w { background-position: -240px -32px; }
.ui-icon-arrowthick-1-n { background-position: 0 -48px; }
.ui-icon-arrowthick-1-ne { background-position: -16px -48px; }
.ui-icon-arrowthick-1-e { background-position: -32px -48px; }
.ui-icon-arrowthick-1-se { background-position: -48px -48px; }
.ui-icon-arrowthick-1-s { background-position: -64px -48px; }
.ui-icon-arrowthick-1-sw { background-position: -80px -48px; }
.ui-icon-arrowthick-1-w { background-position: -96px -48px; }
.ui-icon-arrowthick-1-nw { background-position: -112px -48px; }
.ui-icon-arrowthick-2-n-s { background-position: -128px -48px; }
.ui-icon-arrowthick-2-ne-sw { background-position: -144px -48px; }
.ui-icon-arrowthick-2-e-w { background-position: -160px -48px; }
.ui-icon-arrowthick-2-se-nw { background-position: -176px -48px; }
.ui-icon-arrowthickstop-1-n { background-position: -192px -48px; }
.ui-icon-arrowthickstop-1-e { background-position: -208px -48px; }
.ui-icon-arrowthickstop-1-s { background-position: -224px -48px; }
.ui-icon-arrowthickstop-1-w { background-position: -240px -48px; }
.ui-icon-arrowreturnthick-1-w { background-position: 0 -64px; }
.ui-icon-arrowreturnthick-1-n { background-position: -16px -64px; }
.ui-icon-arrowreturnthick-1-e { background-position: -32px -64px; }
.ui-icon-arrowreturnthick-1-s { background-position: -48px -64px; }
.ui-icon-arrowreturn-1-w { background-position: -64px -64px; }
.ui-icon-arrowreturn-1-n { background-position: -80px -64px; }
.ui-icon-arrowreturn-1-e { background-position: -96px -64px; }
.ui-icon-arrowreturn-1-s { background-position: -112px -64px; }
.ui-icon-arrowrefresh-1-w { background-position: -128px -64px; }
.ui-icon-arrowrefresh-1-n { background-position: -144px -64px; }
.ui-icon-arrowrefresh-1-e { background-position: -160px -64px; }
.ui-icon-arrowrefresh-1-s { background-position: -176px -64px; }
.ui-icon-arrow-4 { background-position: 0 -80px; }
.ui-icon-arrow-4-diag { background-position: -16px -80px; }
.ui-icon-extlink { background-position: -32px -80px; }
.ui-icon-newwin { background-position: -48px -80px; }
.ui-icon-refresh { background-position: -64px -80px; }
.ui-icon-shuffle { background-position: -80px -80px; }
.ui-icon-transfer-e-w { background-position: -96px -80px; }
.ui-icon-transferthick-e-w { background-position: -112px -80px; }
.ui-icon-folder-collapsed { background-position: 0 -96px; }
.ui-icon-folder-open { background-position: -16px -96px; }
.ui-icon-document { background-position: -32px -96px; }
.ui-icon-document-b { background-position: -48px -96px; }
.ui-icon-note { background-position: -64px -96px; }
.ui-icon-mail-closed { background-position: -80px -96px; }
.ui-icon-mail-open { background-position: -96px -96px; }
.ui-icon-suitcase { background-position: -112px -96px; }
.ui-icon-comment { background-position: -128px -96px; }
.ui-icon-person { background-position: -144px -96px; }
.ui-icon-print { background-position: -160px -96px; }
.ui-icon-trash { background-position: -176px -96px; }
.ui-icon-locked { background-position: -192px -96px; }
.ui-icon-unlocked { background-position: -208px -96px; }
.ui-icon-bookmark { background-position: -224px -96px; }
.ui-icon-tag { background-position: -240px -96px; }
.ui-icon-home { background-position: 0 -112px; }
.ui-icon-flag { background-position: -16px -112px; }
.ui-icon-calendar { background-position: -32px -112px; }
.ui-icon-cart { background-position: -48px -112px; }
.ui-icon-pencil { background-position: -64px -112px; }
.ui-icon-clock { background-position: -80px -112px; }
.ui-icon-disk { background-position: -96px -112px; }
.ui-icon-calculator { background-position: -112px -112px; }
.ui-icon-zoomin { background-position: -128px -112px; }
.ui-icon-zoomout { background-position: -144px -112px; }
.ui-icon-search { background-position: -160px -112px; }
.ui-icon-wrench { background-position: -176px -112px; }
.ui-icon-gear { background-position: -192px -112px; }
.ui-icon-heart { background-position: -208px -112px; }
.ui-icon-star { background-position: -224px -112px; }
.ui-icon-link { background-position: -240px -112px; }
.ui-icon-cancel { background-position: 0 -128px; }
.ui-icon-plus { background-position: -16px -128px; }
.ui-icon-plusthick { background-position: -32px -128px; }
.ui-icon-minus { background-position: -48px -128px; }
.ui-icon-minusthick { background-position: -64px -128px; }
.ui-icon-close { background-position: -80px -128px; }
.ui-icon-closethick { background-position: -96px -128px; }
.ui-icon-key { background-position: -112px -128px; }
.ui-icon-lightbulb { background-position: -128px -128px; }
.ui-icon-scissors { background-position: -144px -128px; }
.ui-icon-clipboard { background-position: -160px -128px; }
.ui-icon-copy { background-position: -176px -128px; }
.ui-icon-contact { background-position: -192px -128px; }
.ui-icon-image { background-position: -208px -128px; }
.ui-icon-video { background-position: -224px -128px; }
.ui-icon-script { background-position: -240px -128px; }
.ui-icon-alert { background-position: 0 -144px; }
.ui-icon-info { background-position: -16px -144px; }
.ui-icon-notice { background-position: -32px -144px; }
.ui-icon-help { background-position: -48px -144px; }
.ui-icon-check { background-position: -64px -144px; }
.ui-icon-bullet { background-position: -80px -144px; }
.ui-icon-radio-off { background-position: -96px -144px; }
.ui-icon-radio-on { background-position: -112px -144px; }
.ui-icon-pin-w { background-position: -128px -144px; }
.ui-icon-pin-s { background-position: -144px -144px; }
.ui-icon-play { background-position: 0 -160px; }
.ui-icon-pause { background-position: -16px -160px; }
.ui-icon-seek-next { background-position: -32px -160px; }
.ui-icon-seek-prev { background-position: -48px -160px; }
.ui-icon-seek-end { background-position: -64px -160px; }
.ui-icon-seek-start { background-position: -80px -160px; }
/* ui-icon-seek-first is deprecated, use ui-icon-seek-start instead */
.ui-icon-seek-first { background-position: -80px -160px; }
.ui-icon-stop { background-position: -96px -160px; }
.ui-icon-eject { background-position: -112px -160px; }
.ui-icon-volume-off { background-position: -128px -160px; }
.ui-icon-volume-on { background-position: -144px -160px; }
.ui-icon-power { background-position: 0 -176px; }
.ui-icon-signal-diag { background-position: -16px -176px; }
.ui-icon-signal { background-position: -32px -176px; }
.ui-icon-battery-0 { background-position: -48px -176px; }
.ui-icon-battery-1 { background-position: -64px -176px; }
.ui-icon-battery-2 { background-position: -80px -176px; }
.ui-icon-battery-3 { background-position: -96px -176px; }
.ui-icon-circle-plus { background-position: 0 -192px; }
.ui-icon-circle-minus { background-position: -16px -192px; }
.ui-icon-circle-close { background-position: -32px -192px; }
.ui-icon-circle-triangle-e { background-position: -48px -192px; }
.ui-icon-circle-triangle-s { background-position: -64px -192px; }
.ui-icon-circle-triangle-w { background-position: -80px -192px; }
.ui-icon-circle-triangle-n { background-position: -96px -192px; }
.ui-icon-circle-arrow-e { background-position: -112px -192px; }
.ui-icon-circle-arrow-s { background-position: -128px -192px; }
.ui-icon-circle-arrow-w { background-position: -144px -192px; }
.ui-icon-circle-arrow-n { background-position: -160px -192px; }
.ui-icon-circle-zoomin { background-position: -176px -192px; }
.ui-icon-circle-zoomout { background-position: -192px -192px; }
.ui-icon-circle-check { background-position: -208px -192px; }
.ui-icon-circlesmall-plus { background-position: 0 -208px; }
.ui-icon-circlesmall-minus { background-position: -16px -208px; }
.ui-icon-circlesmall-close { background-position: -32px -208px; }
.ui-icon-squaresmall-plus { background-position: -48px -208px; }
.ui-icon-squaresmall-minus { background-position: -64px -208px; }
.ui-icon-squaresmall-close { background-position: -80px -208px; }
.ui-icon-grip-dotted-vertical { background-position: 0 -224px; }
.ui-icon-grip-dotted-horizontal { background-position: -16px -224px; }
.ui-icon-grip-solid-vertical { background-position: -32px -224px; }
.ui-icon-grip-solid-horizontal { background-position: -48px -224px; }
.ui-icon-gripsmall-diagonal-se { background-position: -64px -224px; }
.ui-icon-grip-diagonal-se { background-position: -80px -224px; }


/* Misc visuals
----------------------------------*/

/* Corner radius */
.ui-corner-tl { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; border-top-left-radius: 4px; }
.ui-corner-tr { -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; border-top-right-radius: 4px; }
.ui-corner-bl { -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; border-bottom-left-radius: 4px; }
.ui-corner-br { -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; border-bottom-right-radius: 4px; }
.ui-corner-top { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; border-top-left-radius: 4px; -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; border-top-right-radius: 4px; }
.ui-corner-bottom { -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; border-bottom-left-radius: 4px; -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; border-bottom-right-radius: 4px; }
.ui-corner-right {  -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; border-top-right-radius: 4px; -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; border-bottom-right-radius: 4px; }
.ui-corner-left { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; border-top-left-radius: 4px; -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; border-bottom-left-radius: 4px; }
.ui-corner-all { -moz-border-radius: 4px; -webkit-border-radius: 4px; border-radius: 4px; }

/* Overlays */
.ui-widget-overlay { background: #aaaaaa url(ui-bg_flat_0_aaaaaa_40x100.png) 50% 50% repeat-x; opacity: .30;filter:Alpha(Opacity=30); }
.ui-widget-shadow { margin: -8px 0 0 -8px; padding: 8px; background: #aaaaaa url(ui-bg_flat_0_aaaaaa_40x100.png) 50% 50% repeat-x; opacity: .30;filter:Alpha(Opacity=30); -moz-border-radius: 8px; -webkit-border-radius: 8px; border-radius: 8px; }/*
 * jQuery UI Resizable @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Resizable#theming
 */
.ui-resizable { position: relative;}
.ui-resizable-handle { position: absolute;font-size: 0.1px;z-index: 99999; display: block;}
.ui-resizable-disabled .ui-resizable-handle, .ui-resizable-autohide .ui-resizable-handle { display: none; }
.ui-resizable-n { cursor: n-resize; height: 7px; width: 100%; top: -5px; left: 0; }
.ui-resizable-s { cursor: s-resize; height: 7px; width: 100%; bottom: -5px; left: 0; }
.ui-resizable-e { cursor: e-resize; width: 7px; right: -5px; top: 0; height: 100%; }
.ui-resizable-w { cursor: w-resize; width: 7px; left: -5px; top: 0; height: 100%; }
.ui-resizable-se { cursor: se-resize; width: 12px; height: 12px; right: 1px; bottom: 1px; }
.ui-resizable-sw { cursor: sw-resize; width: 9px; height: 9px; left: -5px; bottom: -5px; }
.ui-resizable-nw { cursor: nw-resize; width: 9px; height: 9px; left: -5px; top: -5px; }
.ui-resizable-ne { cursor: ne-resize; width: 9px; height: 9px; right: -5px; top: -5px;}/*
 * jQuery UI Selectable @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Selectable#theming
 */
.ui-selectable-helper { position: absolute; z-index: 100; border:1px dotted black; }
/*
 * jQuery UI Accordion @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Accordion#theming
 */
/* IE/Win - Fix animation bug - #4615 */
.ui-accordion { width: 100%; }
.ui-accordion .ui-accordion-header { cursor: pointer; position: relative; margin-top: 1px; zoom: 1; }
.ui-accordion .ui-accordion-li-fix { display: inline; }
.ui-accordion .ui-accordion-header-active { border-bottom: 0 !important; }
.ui-accordion .ui-accordion-header a { display: block; font-size: 1em; padding: .5em .5em .5em .7em; }
.ui-accordion-icons .ui-accordion-header a { padding-left: 2.2em; }
.ui-accordion .ui-accordion-header .ui-icon { position: absolute; left: .5em; top: 50%; margin-top: -8px; }
.ui-accordion .ui-accordion-content { padding: 1em 2.2em; border-top: 0; margin-top: -2px; position: relative; top: 1px; margin-bottom: 2px; overflow: auto; display: none; zoom: 1; }
.ui-accordion .ui-accordion-content-active { display: block; }/*
 * jQuery UI Autocomplete @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Autocomplete#theming
 */
.ui-autocomplete { position: absolute; cursor: default; }	

/* workarounds */
* html .ui-autocomplete { width:1px; } /* without this, the menu expands to 100% in IE6 */

/*
 * jQuery UI Menu @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Menu#theming
 */
.ui-menu {
	list-style:none;
	padding: 2px;
	margin: 0;
	display:block;
	float: left;
}
.ui-menu .ui-menu {
	margin-top: -3px;
}
.ui-menu .ui-menu-item {
	margin:0;
	padding: 0;
	zoom: 1;
	float: left;
	clear: left;
	width: 100%;
}
.ui-menu .ui-menu-item a {
	text-decoration:none;
	display:block;
	padding:.2em .4em;
	line-height:1.5;
	zoom:1;
}
.ui-menu .ui-menu-item a.ui-state-hover,
.ui-menu .ui-menu-item a.ui-state-active {
	font-weight: normal;
	margin: -1px;
}
/*
 * jQuery UI Button @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Button#theming
 */
.ui-button { display: inline-block; position: relative; padding: 0; margin-right: .1em; text-decoration: none !important; cursor: pointer; text-align: center; zoom: 1; overflow: visible; } /* the overflow property removes extra width in IE */
.ui-button-icon-only { width: 2.2em; } /* to make room for the icon, a width needs to be set here */
button.ui-button-icon-only { width: 2.4em; } /* button elements seem to need a little more width */
.ui-button-icons-only { width: 3.4em; } 
button.ui-button-icons-only { width: 3.7em; } 

/*button text element */
.ui-button .ui-button-text { display: block; line-height: 1.4;  }
.ui-button-text-only .ui-button-text { padding: .4em 1em; }
.ui-button-icon-only .ui-button-text, .ui-button-icons-only .ui-button-text { padding: .4em; text-indent: -9999999px; }
.ui-button-text-icon-primary .ui-button-text, .ui-button-text-icons .ui-button-text { padding: .4em 1em .4em 2.1em; }
.ui-button-text-icon-secondary .ui-button-text, .ui-button-text-icons .ui-button-text { padding: .4em 2.1em .4em 1em; }
.ui-button-text-icons .ui-button-text { padding-left: 2.1em; padding-right: 2.1em; }
/* no icon support for input elements, provide padding by default */
input.ui-button { padding: .4em 1em; }

/*button icon element(s) */
.ui-button-icon-only .ui-icon, .ui-button-text-icon-primary .ui-icon, .ui-button-text-icon-secondary .ui-icon, .ui-button-text-icons .ui-icon, .ui-button-icons-only .ui-icon { position: absolute; top: 50%; margin-top: -8px; }
.ui-button-icon-only .ui-icon { left: 50%; margin-left: -8px; }
.ui-button-text-icon-primary .ui-button-icon-primary, .ui-button-text-icons .ui-button-icon-primary, .ui-button-icons-only .ui-button-icon-primary { left: .5em; }
.ui-button-text-icon-secondary .ui-button-icon-secondary, .ui-button-text-icons .ui-button-icon-secondary, .ui-button-icons-only .ui-button-icon-secondary { right: .5em; }
.ui-button-text-icons .ui-button-icon-secondary, .ui-button-icons-only .ui-button-icon-secondary { right: .5em; }

/*button sets*/
.ui-buttonset { margin-right: 7px; }
.ui-buttonset .ui-button { margin-left: 0; margin-right: -.3em; }

/* workarounds */
button.ui-button::-moz-focus-inner { border: 0; padding: 0; } /* reset extra padding in Firefox */
/*
 * jQuery UI Dialog @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Dialog#theming
 */
.ui-dialog { position: absolute; padding: .2em; width: 300px; overflow: hidden; }
.ui-dialog .ui-dialog-titlebar { padding: .5em 1em .3em; position: relative;  }
.ui-dialog .ui-dialog-title { float: left; margin: .1em 16px .2em 0; } 
.ui-dialog .ui-dialog-titlebar-close { position: absolute; right: .3em; top: 50%; width: 19px; margin: -10px 0 0 0; padding: 1px; height: 18px; }
.ui-dialog .ui-dialog-titlebar-close span { display: block; margin: 1px; }
.ui-dialog .ui-dialog-titlebar-close:hover, .ui-dialog .ui-dialog-titlebar-close:focus { padding: 0; }
.ui-dialog .ui-dialog-content { position: relative; border: 0; padding: .5em 1em; background: none; overflow: auto; zoom: 1; }
.ui-dialog .ui-dialog-buttonpane { text-align: left; border-width: 1px 0 0 0; background-image: none; margin: .5em 0 0 0; padding: .3em 1em .5em .4em; }
.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset { float: right; }
.ui-dialog .ui-dialog-buttonpane button { margin: .5em .4em .5em 0; cursor: pointer; }
.ui-dialog .ui-resizable-se { width: 14px; height: 14px; right: 3px; bottom: 3px; }
.ui-draggable .ui-dialog-titlebar { cursor: move; }
/*
 * jQuery UI Slider @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Slider#theming
 */
.ui-slider { position: relative; text-align: left; }
.ui-slider .ui-slider-handle { position: absolute; z-index: 2; width: 1.2em; height: 1.2em; cursor: default; }
.ui-slider .ui-slider-range { position: absolute; z-index: 1; font-size: .7em; display: block; border: 0; background-position: 0 0; }

.ui-slider-horizontal { height: .8em; }
.ui-slider-horizontal .ui-slider-handle { top: -.3em; margin-left: -.6em; }
.ui-slider-horizontal .ui-slider-range { top: 0; height: 100%; }
.ui-slider-horizontal .ui-slider-range-min { left: 0; }
.ui-slider-horizontal .ui-slider-range-max { right: 0; }

.ui-slider-vertical { width: .8em; height: 100px; }
.ui-slider-vertical .ui-slider-handle { left: -.3em; margin-left: 0; margin-bottom: -.6em; }
.ui-slider-vertical .ui-slider-range { left: 0; width: 100%; }
.ui-slider-vertical .ui-slider-range-min { bottom: 0; }
.ui-slider-vertical .ui-slider-range-max { top: 0; }/*
 * jQuery UI Tabs @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Tabs#theming
 */
.ui-tabs { position: relative; padding: .2em; zoom: 1; } /* position: relative prevents IE scroll bug (element with position: relative inside container with overflow: auto appear as "fixed") */
.ui-tabs .ui-tabs-nav { margin: 0; padding: .2em .2em 0; }
.ui-tabs .ui-tabs-nav li { list-style: none; float: left; position: relative; top: 1px; margin: 0 .2em 1px 0; border-bottom: 0 !important; padding: 0; white-space: nowrap; }
.ui-tabs .ui-tabs-nav li a { float: left; padding: .5em 1em; text-decoration: none; }
.ui-tabs .ui-tabs-nav li.ui-tabs-selected { margin-bottom: 0; padding-bottom: 1px; }
.ui-tabs .ui-tabs-nav li.ui-tabs-selected a, .ui-tabs .ui-tabs-nav li.ui-state-disabled a, .ui-tabs .ui-tabs-nav li.ui-state-processing a { cursor: text; }
.ui-tabs .ui-tabs-nav li a, .ui-tabs.ui-tabs-collapsible .ui-tabs-nav li.ui-tabs-selected a { cursor: pointer; } /* first selector in group seems obsolete, but required to overcome bug in Opera applying cursor: text overall if defined elsewhere... */
.ui-tabs .ui-tabs-panel { display: block; border-width: 0; padding: 1em 1.4em; background: none; }
.ui-tabs .ui-tabs-hide { display: none !important; }
/*
 * jQuery UI Datepicker @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Datepicker#theming
 */
.ui-datepicker { width: 17em; padding: .2em .2em 0; }
.ui-datepicker .ui-datepicker-header { position:relative; padding:.2em 0; }
.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next { position:absolute; top: 2px; width: 1.8em; height: 1.8em; }
.ui-datepicker .ui-datepicker-prev-hover, .ui-datepicker .ui-datepicker-next-hover { top: 1px; }
.ui-datepicker .ui-datepicker-prev { left:2px; }
.ui-datepicker .ui-datepicker-next { right:2px; }
.ui-datepicker .ui-datepicker-prev-hover { left:1px; }
.ui-datepicker .ui-datepicker-next-hover { right:1px; }
.ui-datepicker .ui-datepicker-prev span, .ui-datepicker .ui-datepicker-next span { display: block; position: absolute; left: 50%; margin-left: -8px; top: 50%; margin-top: -8px;  }
.ui-datepicker .ui-datepicker-title { margin: 0 2.3em; line-height: 1.8em; text-align: center; }
.ui-datepicker .ui-datepicker-title select { font-size:1em; margin:1px 0; }
.ui-datepicker select.ui-datepicker-month-year {width: 100%;}
.ui-datepicker select.ui-datepicker-month, 
.ui-datepicker select.ui-datepicker-year { width: 49%;}
.ui-datepicker table {width: 100%; font-size: .9em; border-collapse: collapse; margin:0 0 .4em; }
.ui-datepicker th { padding: .7em .3em; text-align: center; font-weight: bold; border: 0;  }
.ui-datepicker td { border: 0; padding: 1px; }
.ui-datepicker td span, .ui-datepicker td a { display: block; padding: .2em; text-align: right; text-decoration: none; }
.ui-datepicker .ui-datepicker-buttonpane { background-image: none; margin: .7em 0 0 0; padding:0 .2em; border-left: 0; border-right: 0; border-bottom: 0; }
.ui-datepicker .ui-datepicker-buttonpane button { float: right; margin: .5em .2em .4em; cursor: pointer; padding: .2em .6em .3em .6em; width:auto; overflow:visible; }
.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current { float:left; }

/* with multiple calendars */
.ui-datepicker.ui-datepicker-multi { width:auto; }
.ui-datepicker-multi .ui-datepicker-group { float:left; }
.ui-datepicker-multi .ui-datepicker-group table { width:95%; margin:0 auto .4em; }
.ui-datepicker-multi-2 .ui-datepicker-group { width:50%; }
.ui-datepicker-multi-3 .ui-datepicker-group { width:33.3%; }
.ui-datepicker-multi-4 .ui-datepicker-group { width:25%; }
.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header { border-left-width:0; }
.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header { border-left-width:0; }
.ui-datepicker-multi .ui-datepicker-buttonpane { clear:left; }
.ui-datepicker-row-break { clear:both; width:100%; }

/* RTL support */
.ui-datepicker-rtl { direction: rtl; }
.ui-datepicker-rtl .ui-datepicker-prev { right: 2px; left: auto; }
.ui-datepicker-rtl .ui-datepicker-next { left: 2px; right: auto; }
.ui-datepicker-rtl .ui-datepicker-prev:hover { right: 1px; left: auto; }
.ui-datepicker-rtl .ui-datepicker-next:hover { left: 1px; right: auto; }
.ui-datepicker-rtl .ui-datepicker-buttonpane { clear:right; }
.ui-datepicker-rtl .ui-datepicker-buttonpane button { float: left; }
.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current { float:right; }
.ui-datepicker-rtl .ui-datepicker-group { float:right; }
.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header { border-right-width:0; border-left-width:1px; }
.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header { border-right-width:0; border-left-width:1px; }

/* IE6 IFRAME FIX (taken from datepicker 1.5.3 */
.ui-datepicker-cover {
    display: none; /*sorry for IE5*/
    display/**/: block; /*sorry for IE5*/
    position: absolute; /*must have*/
    z-index: -1; /*must have*/
    filter: mask(); /*must have*/
    top: -4px; /*must have*/
    left: -4px; /*must have*/
    width: 200px; /*must have*/
    height: 200px; /*must have*/
}/*
 * jQuery UI Progressbar @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Progressbar#theming
 */
.ui-progressbar { height:2em; text-align: left; }
.ui-progressbar .ui-progressbar-value {margin: -1px; height:100%; }'
]

{ #category : #uploaded }
JQSGLTheme >> uibgflat0aaaaaa40x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 40 0 0 0 100 8 6 0 0 0 244 100 114 122 0 0 0 123 73 68 65 84 104 129 237 206 49 1 192 32 16 0 49 192 191 146 55 89 36 116 200 208 14 23 5 217 51 243 172 31 59 95 7 222 20 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 5 85 65 85 80 21 84 23 195 188 3 197 157 99 170 41 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibgflat75ffffff40x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 40 0 0 0 100 8 6 0 0 0 244 100 114 122 0 0 0 121 73 68 65 84 104 129 237 206 49 1 192 32 16 0 177 82 255 158 31 9 12 55 192 144 40 200 154 153 249 30 246 223 14 156 8 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 130 149 96 37 88 9 86 27 106 139 4 196 41 50 215 78 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibgglass55fbf9ee1x400Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 1 0 0 1 144 8 6 0 0 0 111 88 10 219 0 0 0 63 73 68 65 84 56 141 237 207 49 10 192 48 0 66 209 175 247 191 108 215 210 96 151 54 67 160 115 160 184 60 4 93 228 58 143 24 160 148 242 91 146 241 38 192 66 24 130 65 24 9 19 158 164 101 55 219 108 255 81 74 249 228 6 197 156 16 6 81 89 200 42 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibginsetsoft65cccccc1x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 1 0 0 0 100 8 6 0 0 0 71 44 90 96 0 0 0 47 73 68 65 84 24 149 99 56 115 230 204 127 38 6 6 6 134 97 72 48 50 50 66 9 52 46 19 19 19 84 12 193 66 72 32 212 97 211 139 141 24 120 175 146 66 0 0 141 163 4 102 45 50 10 135 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibginsetsoft75ccccca1x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 1 0 0 0 100 8 6 0 0 1 48 43 106 246 0 0 0 89 73 68 65 84 24 149 181 143 75 10 192 32 12 68 199 153 4 163 247 63 85 241 78 237 70 93 217 34 66 55 15 2 147 249 160 181 235 38 0 44 225 238 96 173 21 204 57 150 18 188 26 144 4 35 2 44 165 128 146 237 255 126 195 204 38 188 151 148 212 35 55 93 78 195 15 65 114 66 160 180 58 199 132 148 82 199 31 93 30 128 158 15 81 250 0 127 238 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibginsetsoft75dddddd1x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 1 0 0 0 100 8 6 0 0 0 71 44 90 96 0 0 0 38 73 68 65 84 24 149 99 184 123 247 238 127 38 6 6 6 134 97 72 48 50 50 98 103 161 17 216 36 240 139 161 201 14 188 87 73 33 0 227 125 4 138 161 170 243 254 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uibginsetsoft95fef1ec1x100Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 1 0 0 0 100 8 6 0 0 0 71 44 90 96 0 0 0 66 73 68 65 84 24 149 221 207 59 14 132 0 20 66 209 195 219 255 82 109 220 192 96 225 39 25 75 27 19 27 194 5 26 252 214 165 3 159 145 182 70 98 194 225 90 38 137 17 166 152 200 209 186 118 220 208 153 237 216 127 124 251 234 51 217 0 139 120 11 178 91 184 133 170 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uiicons222222256x240Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 1 0 0 0 0 240 8 3 0 0 0 216 73 74 249 0 0 0 237 80 76 84 69 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 36 34 36 240 195 136 20 0 0 0 78 116 82 78 83 0 24 16 50 4 8 80 191 131 153 46 34 84 112 64 102 96 26 18 205 12 32 60 22 66 72 74 30 90 38 48 82 44 133 52 135 129 195 106 201 207 199 56 68 28 189 185 124 171 181 165 141 169 173 179 40 253 159 36 239 10 6 2 143 163 98 149 161 175 108 223 157 70 62 110 126 145 104 104 210 72 253 0 0 15 133 73 68 65 84 120 156 237 93 141 98 219 182 17 6 201 72 170 229 132 146 45 123 105 236 90 75 58 103 243 146 108 107 215 110 173 154 45 169 211 116 73 215 245 222 255 113 6 128 4 113 63 32 32 69 178 36 219 248 100 75 62 2 36 238 62 30 193 59 0 148 149 202 200 200 216 3 20 80 236 90 133 157 162 0 216 115 6 214 86 175 128 104 33 20 152 1 83 121 187 132 48 15 4 3 69 183 48 125 72 185 41 45 240 22 224 230 22 116 11 107 128 237 111 255 220 170 75 112 15 148 4 20 92 31 82 206 207 160 32 128 239 46 27 16 149 69 139 55 8 161 191 10 154 16 41 151 12 42 86 59 126 244 80 101 222 226 13 66 120 176 18 42 242 19 44 61 36 122 134 165 7 68 20 216 190 7 132 16 237 3 162 30 28 172 32 250 0 197 74 177 189 219 239 3 210 184 217 187 0 191 132 182 127 23 216 57 238 123 32 148 145 145 145 145 145 145 177 199 184 241 72 112 199 113 16 87 64 196 242 34 50 39 6 1 240 4 159 219 19 31 15 16 3 66 250 232 91 165 36 160 128 32 64 84 224 213 105 186 72 213 47 228 225 98 217 165 57 250 54 147 33 161 127 88 227 72 113 96 68 69 164 199 42 82 206 0 150 128 173 13 7 72 15 86 33 159 37 217 218 18 227 1 133 162 59 208 242 212 240 193 238 211 225 34 162 241 250 227 1 242 10 217 105 31 144 198 93 191 11 100 100 100 100 100 100 100 100 236 14 235 5 254 201 208 52 121 252 181 19 143 53 15 32 244 143 26 244 9 137 82 98 7 185 28 64 40 148 56 154 220 20 219 67 100 135 246 197 170 208 221 161 175 44 220 64 84 129 64 105 188 253 208 17 98 4 137 114 113 48 97 129 108 14 88 33 244 20 182 7 148 250 176 29 160 175 112 137 246 101 186 44 9 235 223 61 52 98 20 87 32 188 123 164 10 53 176 173 205 198 172 104 117 126 192 40 127 193 26 81 23 138 94 64 129 227 243 51 20 218 61 238 162 233 22 34 133 98 255 228 53 30 88 67 20 27 64 74 31 145 157 142 184 67 135 170 164 250 128 84 233 174 239 2 55 188 127 250 54 153 145 145 145 145 145 145 113 95 177 254 178 212 53 195 12 169 64 44 114 9 197 161 201 169 170 68 243 171 41 176 84 3 241 124 158 79 156 133 20 64 229 10 79 78 45 17 213 153 202 253 201 9 4 167 247 165 146 226 144 253 237 7 242 91 110 64 236 216 82 1 188 161 153 88 244 20 73 109 3 139 221 139 40 1 137 181 225 161 70 32 202 64 148 63 177 240 61 48 222 18 160 8 112 117 76 145 152 59 103 30 36 210 225 64 54 206 183 132 244 23 10 132 75 3 7 96 26 202 253 3 62 208 191 187 32 64 104 32 213 163 229 252 18 75 19 16 86 128 110 17 21 18 197 34 97 166 34 171 143 11 249 37 16 108 130 27 64 46 1 118 137 36 47 129 240 85 94 244 214 16 12 71 23 7 200 58 1 7 35 96 157 96 160 146 32 128 117 130 172 84 116 75 169 17 28 222 126 224 28 197 139 195 90 160 221 249 53 28 84 188 191 137 37 214 107 236 245 120 192 174 159 143 201 200 200 200 200 200 216 107 220 236 93 92 6 42 236 81 217 192 30 155 13 44 210 135 139 5 210 235 66 134 170 52 52 11 218 79 88 75 205 124 5 138 121 130 206 103 131 185 193 16 43 95 19 77 164 40 22 3 251 108 208 190 69 158 14 79 132 250 129 10 32 12 86 36 251 84 49 66 88 245 245 1 146 1 98 162 45 138 124 63 64 32 212 102 243 213 66 223 88 114 224 246 37 39 64 210 185 65 2 92 186 73 180 225 185 74 44 125 134 128 66 66 99 225 243 92 6 86 10 241 202 114 141 193 167 163 8 104 40 210 93 116 73 200 236 94 170 25 243 17 161 125 220 199 197 25 111 206 215 166 111 12 190 83 51 131 9 34 59 163 207 247 7 202 153 16 186 236 209 193 98 125 220 18 157 34 223 176 9 16 15 151 217 41 123 98 36 145 189 166 22 1 165 198 31 226 227 71 119 16 119 221 190 140 140 140 140 140 187 141 242 150 223 200 2 97 135 156 222 98 34 222 240 41 246 239 211 84 64 112 154 133 70 95 101 114 54 16 74 118 208 168 168 2 225 246 14 193 34 109 232 222 173 172 77 45 193 159 100 55 243 234 54 148 208 120 128 175 175 132 203 176 54 2 211 165 59 4 200 236 133 47 175 215 246 147 236 140 16 96 62 75 114 4 80 92 196 246 22 176 95 4 184 217 235 94 117 140 49 37 147 219 79 21 250 84 130 77 178 173 232 46 177 125 185 4 150 240 0 81 31 51 230 8 234 241 128 182 46 27 78 216 179 7 228 227 125 0 171 17 28 161 41 189 151 240 62 128 247 5 251 228 254 45 226 119 129 96 151 143 234 151 97 131 248 16 151 195 22 191 43 115 121 36 227 128 228 1 202 116 29 135 248 151 41 220 78 172 98 127 70 70 70 70 198 253 66 101 226 132 106 249 250 15 6 26 15 110 78 31 138 161 86 110 52 140 213 248 44 17 185 193 65 19 42 245 153 88 241 226 42 206 199 3 53 6 24 171 7 164 62 217 227 80 139 135 170 71 230 133 234 97 11 182 131 51 9 30 213 245 16 5 123 246 111 66 136 13 139 38 60 20 244 148 76 91 11 167 196 222 78 99 46 139 153 173 195 182 220 105 61 24 195 96 0 227 1 81 64 137 100 130 175 181 13 10 205 134 73 168 197 46 73 171 235 186 108 192 8 25 17 2 16 3 96 92 116 224 91 60 32 4 232 67 31 105 116 161 52 56 15 192 249 52 201 45 6 3 114 192 1 12 142 143 43 192 4 204 102 179 216 236 145 177 6 130 66 144 128 67 66 32 24 211 209 6 77 72 129 9 105 20 164 132 159 24 244 121 0 12 1 125 152 134 219 62 192 201 205 114 120 164 241 137 221 253 196 19 112 124 122 248 59 66 192 227 199 143 21 59 225 98 177 117 175 139 114 2 140 253 159 99 2 168 75 129 182 159 250 24 52 116 160 6 31 27 244 122 192 145 49 29 134 71 126 28 160 178 254 223 17 96 142 143 134 216 154 195 249 3 234 75 224 201 19 124 9 204 148 62 5 250 189 219 161 178 175 79 36 192 216 255 240 236 243 126 2 10 182 65 111 41 138 163 2 165 48 112 122 122 10 189 125 0 28 105 6 180 253 152 0 251 211 17 96 59 65 68 192 185 217 251 252 220 109 56 110 58 193 99 102 14 218 65 18 64 115 55 186 193 18 240 5 30 159 152 76 31 234 247 186 143 0 222 32 28 90 160 6 47 46 46 192 187 168 240 128 234 104 56 212 111 254 18 176 114 63 1 23 13 218 13 197 24 78 199 227 57 140 241 51 66 232 18 210 27 126 111 95 216 222 1 39 96 192 8 0 226 1 19 111 127 132 128 238 112 79 45 152 203 13 58 2 184 7 84 71 22 238 20 9 25 76 31 59 244 199 55 26 141 199 221 93 96 236 218 31 19 2 176 66 146 128 212 37 128 203 155 62 176 238 42 119 4 84 180 189 238 112 77 28 0 159 169 30 48 15 72 221 6 27 125 38 116 12 166 242 183 238 206 94 49 136 214 39 79 113 243 114 3 39 192 50 80 171 205 161 170 166 22 43 196 122 28 44 116 73 87 39 39 124 101 28 110 212 254 140 140 140 140 140 61 199 179 103 241 242 82 204 109 19 152 91 78 242 182 83 249 116 247 75 123 155 250 210 137 109 178 221 229 216 147 86 158 116 251 54 161 201 225 210 178 82 127 96 250 212 209 251 154 206 182 78 216 38 125 219 246 66 9 85 229 25 24 153 40 242 114 60 244 113 200 129 86 121 114 208 5 114 65 42 42 191 221 216 175 16 3 122 103 3 54 211 68 35 155 177 9 5 151 150 155 243 209 89 80 155 96 174 236 238 237 165 225 118 130 207 233 115 128 231 204 126 19 40 157 122 251 77 108 222 101 191 124 117 184 8 204 20 252 81 191 30 97 133 42 125 158 43 84 159 204 13 178 3 128 250 147 186 82 127 198 249 237 88 11 99 34 43 42 159 12 78 144 108 244 159 78 251 20 4 104 99 191 70 116 14 135 60 78 43 59 45 125 232 216 140 88 116 217 149 36 128 165 195 160 94 156 191 124 117 118 142 134 141 42 237 223 126 192 39 69 192 95 224 175 250 53 194 6 234 210 49 147 113 242 161 115 227 1 42 159 82 5 219 96 222 79 206 146 246 158 57 17 245 3 35 120 52 213 28 52 194 129 27 177 57 232 35 160 237 5 188 172 207 254 223 224 153 87 72 219 143 134 236 210 30 240 149 250 90 253 221 15 41 93 48 15 184 96 30 112 193 60 160 181 223 157 193 26 154 78 170 203 111 89 123 223 52 210 55 157 130 54 153 199 185 3 152 62 192 219 151 38 224 197 249 23 135 250 21 182 191 141 212 49 1 37 216 81 39 39 127 5 223 234 215 63 156 108 218 195 215 184 149 43 38 163 114 123 253 106 184 78 145 19 224 178 187 174 15 160 230 52 252 41 12 218 203 195 96 168 78 1 231 139 140 128 46 189 11 219 223 173 136 160 4 32 249 252 235 199 163 199 255 252 174 149 143 220 225 14 151 147 167 244 236 41 113 9 180 50 22 159 63 247 178 241 253 110 188 51 72 128 98 208 27 204 248 96 239 125 16 216 32 247 151 173 194 254 46 96 150 24 241 245 6 29 129 250 143 167 236 112 113 89 49 251 101 2 95 98 251 213 203 239 117 247 55 249 254 101 43 78 205 245 95 70 246 23 134 182 221 40 234 68 129 84 19 131 252 44 14 224 195 222 76 14 125 3 76 76 158 114 251 249 109 80 53 139 186 124 177 157 17 120 232 138 165 7 49 140 99 133 251 138 120 32 68 65 98 160 140 140 140 140 140 29 96 136 7 166 77 40 7 23 177 234 55 188 180 208 78 69 68 239 126 60 118 92 9 37 44 244 251 2 223 154 47 1 133 154 159 195 112 248 195 15 240 29 82 231 17 222 127 126 6 47 94 192 217 220 201 108 189 133 27 110 112 227 13 157 204 55 116 201 27 143 155 198 48 26 14 95 19 6 184 189 171 17 48 213 199 26 163 108 19 52 3 11 30 141 159 250 200 235 95 6 255 246 161 232 98 168 15 48 21 201 77 87 206 166 106 217 31 109 242 234 235 232 208 177 210 201 142 159 28 108 10 124 114 101 2 227 5 188 230 227 13 138 200 171 16 96 66 45 180 135 177 221 254 118 21 46 105 232 249 230 141 82 111 222 120 125 134 10 234 41 158 217 225 4 144 37 35 96 7 163 208 130 135 82 53 67 21 29 1 186 170 25 143 65 4 188 50 115 117 184 193 133 97 189 143 0 224 26 8 115 89 121 51 187 231 61 106 97 101 111 127 73 235 55 159 126 242 245 173 46 26 161 112 21 6 108 65 6 221 223 206 131 162 10 96 18 79 157 207 41 236 1 147 9 94 175 62 158 207 77 122 233 9 208 246 43 52 4 198 25 231 201 66 88 100 46 142 195 77 122 254 203 118 205 136 235 3 190 181 211 207 240 182 171 80 215 100 127 56 137 19 112 172 255 60 54 63 174 216 56 216 16 78 145 7 16 253 42 120 245 234 232 213 28 46 187 3 190 54 218 141 54 71 0 247 128 31 173 236 70 229 90 251 189 129 227 133 197 41 221 221 19 166 79 233 201 201 9 33 160 249 108 197 83 141 115 253 211 17 208 104 179 232 237 3 230 115 115 1 224 78 240 245 112 56 218 96 39 8 180 15 48 246 47 60 3 198 254 154 164 163 115 163 239 169 223 125 241 8 46 17 3 230 64 199 168 219 115 131 55 206 190 167 79 219 159 86 238 6 68 250 250 128 97 53 159 207 97 142 25 0 118 27 220 244 93 224 185 25 152 245 250 240 212 109 49 153 248 1 43 221 3 234 159 210 51 0 228 195 253 121 232 54 240 219 160 245 8 139 158 62 64 223 117 53 48 1 18 235 17 192 80 218 115 255 220 197 1 129 53 130 164 3 49 61 198 235 18 61 167 7 112 253 162 32 42 129 194 75 86 6 149 25 210 171 220 130 141 213 227 128 221 227 248 221 187 99 36 78 31 25 174 52 7 141 40 250 88 185 114 50 35 35 35 99 45 12 241 234 232 179 159 76 23 243 211 217 206 180 217 62 222 3 188 239 132 159 93 175 251 243 14 53 218 46 158 24 115 159 180 194 89 115 199 49 239 222 7 102 48 195 59 252 39 16 204 168 21 6 166 19 152 89 254 103 233 138 155 194 123 147 64 57 23 248 224 9 248 208 213 96 97 67 40 142 168 61 37 98 234 129 111 224 50 204 204 61 29 173 134 222 110 156 242 164 49 248 9 106 156 135 30 66 159 146 111 168 189 83 36 22 110 26 249 227 224 35 157 157 21 205 109 147 0 221 3 152 20 250 61 105 156 234 48 193 19 99 202 218 239 167 23 141 221 200 254 208 210 221 105 57 197 246 125 212 111 31 73 133 217 14 9 168 221 249 174 113 227 84 135 154 93 242 0 87 37 46 195 246 135 8 40 137 203 216 133 230 93 122 219 92 240 120 143 10 102 179 217 246 34 93 111 176 215 39 117 18 208 228 171 181 157 116 138 107 123 192 118 59 65 235 0 205 67 51 214 134 119 158 128 119 168 82 127 31 95 35 247 177 88 187 15 16 12 222 40 120 167 247 210 139 47 113 37 182 19 18 232 249 87 27 184 11 168 254 197 8 155 199 204 27 220 104 112 237 196 107 95 73 246 1 88 138 249 199 39 98 167 201 250 47 102 88 22 222 254 178 75 29 246 105 180 34 35 35 35 35 35 227 134 81 67 76 188 105 192 136 5 50 116 233 232 13 224 224 128 202 53 143 172 182 76 0 48 10 8 1 182 172 196 21 234 81 105 222 72 5 147 50 59 121 210 84 234 79 111 107 22 59 215 162 24 236 12 217 182 96 245 195 22 82 2 154 178 78 103 123 122 180 121 188 2 33 0 151 75 2 120 178 8 162 178 17 183 231 5 109 236 63 65 27 40 1 118 248 163 85 210 126 140 176 206 109 5 76 192 40 96 19 111 47 33 110 242 255 7 164 176 109 15 88 138 128 45 123 192 118 251 0 142 157 247 1 91 190 11 128 32 100 199 119 129 61 192 110 227 128 140 140 140 140 140 251 141 248 115 100 119 29 229 127 21 252 122 142 214 110 234 40 229 242 30 125 79 174 121 142 20 126 173 209 243 12 227 250 109 224 1 10 23 155 240 239 63 88 85 222 59 44 224 127 154 0 133 86 39 43 19 251 11 6 128 127 86 159 38 239 27 74 184 82 234 215 90 93 225 167 173 23 167 58 163 165 207 215 122 67 6 39 3 253 211 45 223 134 19 186 158 221 200 64 229 129 121 13 246 52 188 173 218 117 243 151 254 12 141 167 96 86 219 147 7 119 16 1 246 171 209 138 35 247 253 122 80 64 81 152 13 78 62 50 47 255 253 123 166 92 111 41 142 246 148 0 235 1 26 87 248 140 155 126 97 129 51 120 76 192 119 13 58 23 95 81 222 59 140 236 61 112 138 214 188 232 100 116 8 167 195 30 2 238 92 39 56 6 184 186 188 194 221 126 51 28 225 83 82 80 219 29 161 218 54 198 239 245 249 121 127 43 159 154 207 200 200 200 200 88 27 252 249 128 148 204 23 81 173 42 175 218 222 186 114 10 252 249 128 148 204 151 209 173 42 175 218 222 186 114 10 103 208 225 108 25 153 47 164 92 85 94 181 189 117 229 36 248 243 1 31 252 1 156 124 109 98 195 235 86 110 150 210 218 242 119 157 12 92 86 189 229 31 124 249 135 222 246 21 68 203 205 138 78 86 78 229 230 16 254 121 135 24 192 55 0 157 236 14 162 218 217 224 235 107 60 59 156 170 47 203 69 125 63 69 30 42 199 179 103 225 79 32 250 168 223 126 251 141 232 103 254 156 47 57 191 6 174 30 54 152 202 230 234 189 102 10 99 133 68 125 37 12 138 215 103 4 36 245 81 238 183 71 158 55 246 111 142 128 41 250 14 186 0 1 161 207 85 12 74 182 31 240 144 152 7 152 111 27 153 3 44 79 64 250 18 48 223 190 21 81 40 237 242 192 228 20 129 16 59 158 98 245 185 172 25 152 119 245 147 224 207 7 4 58 53 215 9 250 78 140 119 82 192 229 254 78 53 216 73 242 246 121 39 75 203 29 63 125 178 185 6 58 57 137 109 223 198 214 189 141 174 42 167 177 237 64 102 221 64 106 85 57 141 109 135 178 235 134 210 171 202 25 25 25 25 25 25 25 17 180 129 195 141 201 123 15 246 255 3 211 242 29 36 0 226 4 216 151 151 125 246 237 100 70 128 226 255 244 112 191 209 124 37 33 68 100 70 16 184 183 62 153 253 251 187 125 71 246 128 123 223 7 220 247 187 64 70 70 70 70 70 70 198 166 81 220 158 72 32 185 10 18 170 213 23 186 22 236 255 3 237 51 10 149 208 117 9 2 248 249 190 77 246 111 194 3 184 189 183 202 126 234 1 118 121 187 125 161 109 21 251 119 122 60 216 55 245 21 149 239 110 31 80 57 248 114 198 87 107 255 237 241 129 117 61 160 169 175 176 124 171 236 95 215 3 110 189 253 235 222 5 122 236 191 179 125 64 2 222 254 219 227 3 73 15 88 5 198 110 247 155 145 177 231 248 63 201 230 115 28 31 60 117 80 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uiicons2e83ff256x240Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 1 0 0 0 0 240 8 3 0 0 0 216 73 74 249 0 0 0 237 80 76 84 69 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 44 130 252 203 172 144 77 0 0 0 78 116 82 78 83 0 24 16 50 4 8 80 191 131 153 46 34 84 112 64 102 96 26 18 205 12 32 60 22 66 72 74 30 90 38 48 82 44 133 52 135 129 195 106 201 207 199 56 68 28 189 185 124 171 181 165 141 169 173 179 40 253 159 36 239 10 6 2 143 163 98 149 161 175 108 223 157 70 62 110 126 145 104 104 210 72 253 0 0 15 133 73 68 65 84 120 156 237 93 141 98 219 182 17 6 201 72 170 229 132 146 45 123 105 236 90 75 58 103 243 146 108 107 215 110 173 154 45 169 211 116 73 215 245 222 255 113 6 128 4 113 63 32 32 69 178 36 219 248 100 75 62 2 36 238 62 30 193 59 0 148 149 202 200 200 216 3 20 80 236 90 133 157 162 0 216 115 6 214 86 175 128 104 33 20 152 1 83 121 187 132 48 15 4 3 69 183 48 125 72 185 41 45 240 22 224 230 22 116 11 107 128 237 111 255 220 170 75 112 15 148 4 20 92 31 82 206 207 160 32 128 239 46 27 16 149 69 139 55 8 161 191 10 154 16 41 151 12 42 86 59 126 244 80 101 222 226 13 66 120 176 18 42 242 19 44 61 36 122 134 165 7 68 20 216 190 7 132 16 237 3 162 30 28 172 32 250 0 197 74 177 189 219 239 3 210 184 217 187 0 191 132 182 127 23 216 57 238 123 32 148 145 145 145 145 145 145 177 199 184 241 72 112 199 113 16 87 64 196 242 34 50 39 6 1 240 4 159 219 19 31 15 16 3 66 250 232 91 165 36 160 128 32 64 84 224 213 105 186 72 213 47 228 225 98 217 165 57 250 54 147 33 161 127 88 227 72 113 96 68 69 164 199 42 82 206 0 150 128 173 13 7 72 15 86 33 159 37 217 218 18 227 1 133 162 59 208 242 212 240 193 238 211 225 34 162 241 250 227 1 242 10 217 105 31 144 198 93 191 11 100 100 100 100 100 100 100 100 236 14 235 5 254 201 208 52 121 252 181 19 143 53 15 32 244 143 26 244 9 137 82 98 7 185 28 64 40 148 56 154 220 20 219 67 100 135 246 197 170 208 221 161 175 44 220 64 84 129 64 105 188 253 208 17 98 4 137 114 113 48 97 129 108 14 88 33 244 20 182 7 148 250 176 29 160 175 112 137 246 101 186 44 9 235 223 61 52 98 20 87 32 188 123 164 10 53 176 173 205 198 172 104 117 126 192 40 127 193 26 81 23 138 94 64 129 227 243 51 20 218 61 238 162 233 22 34 133 98 255 228 53 30 88 67 20 27 64 74 31 145 157 142 184 67 135 170 164 250 128 84 233 174 239 2 55 188 127 250 54 153 145 145 145 145 145 145 113 95 177 254 178 212 53 195 12 169 64 44 114 9 197 161 201 169 170 68 243 171 41 176 84 3 241 124 158 79 156 133 20 64 229 10 79 78 45 17 213 153 202 253 201 9 4 167 247 165 146 226 144 253 237 7 242 91 110 64 236 216 82 1 188 161 153 88 244 20 73 109 3 139 221 139 40 1 137 181 225 161 70 32 202 64 148 63 177 240 61 48 222 18 160 8 112 117 76 145 152 59 103 30 36 210 225 64 54 206 183 132 244 23 10 132 75 3 7 96 26 202 253 3 62 208 191 187 32 64 104 32 213 163 229 252 18 75 19 16 86 128 110 17 21 18 197 34 97 166 34 171 143 11 249 37 16 108 130 27 64 46 1 118 137 36 47 129 240 85 94 244 214 16 12 71 23 7 200 58 1 7 35 96 157 96 160 146 32 128 117 130 172 84 116 75 169 17 28 222 126 224 28 197 139 195 90 160 221 249 53 28 84 188 191 137 37 214 107 236 245 120 192 174 159 143 201 200 200 200 200 200 216 107 220 236 93 92 6 42 236 81 217 192 30 155 13 44 210 135 139 5 210 235 66 134 170 52 52 11 218 79 88 75 205 124 5 138 121 130 206 103 131 185 193 16 43 95 19 77 164 40 22 3 251 108 208 190 69 158 14 79 132 250 129 10 32 12 86 36 251 84 49 66 88 245 245 1 146 1 98 162 45 138 124 63 64 32 212 102 243 213 66 223 88 114 224 246 37 39 64 210 185 65 2 92 186 73 180 225 185 74 44 125 134 128 66 66 99 225 243 92 6 86 10 241 202 114 141 193 167 163 8 104 40 210 93 116 73 200 236 94 170 25 243 17 161 125 220 199 197 25 111 206 215 166 111 12 190 83 51 131 9 34 59 163 207 247 7 202 153 16 186 236 209 193 98 125 220 18 157 34 223 176 9 16 15 151 217 41 123 98 36 145 189 166 22 1 165 198 31 226 227 71 119 16 119 221 190 140 140 140 140 140 187 141 242 150 223 200 2 97 135 156 222 98 34 222 240 41 246 239 211 84 64 112 154 133 70 95 101 114 54 16 74 118 208 168 168 2 225 246 14 193 34 109 232 222 173 172 77 45 193 159 100 55 243 234 54 148 208 120 128 175 175 132 203 176 54 2 211 165 59 4 200 236 133 47 175 215 246 147 236 140 16 96 62 75 114 4 80 92 196 246 22 176 95 4 184 217 235 94 117 140 49 37 147 219 79 21 250 84 130 77 178 173 232 46 177 125 185 4 150 240 0 81 31 51 230 8 234 241 128 182 46 27 78 216 179 7 228 227 125 0 171 17 28 161 41 189 151 240 62 128 247 5 251 228 254 45 226 119 129 96 151 143 234 151 97 131 248 16 151 195 22 191 43 115 121 36 227 128 228 1 202 116 29 135 248 151 41 220 78 172 98 127 70 70 70 70 198 253 66 101 226 132 106 249 250 15 6 26 15 110 78 31 138 161 86 110 52 140 213 248 44 17 185 193 65 19 42 245 153 88 241 226 42 206 199 3 53 6 24 171 7 164 62 217 227 80 139 135 170 71 230 133 234 97 11 182 131 51 9 30 213 245 16 5 123 246 111 66 136 13 139 38 60 20 244 148 76 91 11 167 196 222 78 99 46 139 153 173 195 182 220 105 61 24 195 96 0 227 1 81 64 137 100 130 175 181 13 10 205 134 73 168 197 46 73 171 235 186 108 192 8 25 17 2 16 3 96 92 116 224 91 60 32 4 232 67 31 105 116 161 52 56 15 192 249 52 201 45 6 3 114 192 1 12 142 143 43 192 4 204 102 179 216 236 145 177 6 130 66 144 128 67 66 32 24 211 209 6 77 72 129 9 105 20 164 132 159 24 244 121 0 12 1 125 152 134 219 62 192 201 205 114 120 164 241 137 221 253 196 19 112 124 122 248 59 66 192 227 199 143 21 59 225 98 177 117 175 139 114 2 140 253 159 99 2 168 75 129 182 159 250 24 52 116 160 6 31 27 244 122 192 145 49 29 134 71 126 28 160 178 254 223 17 96 142 143 134 216 154 195 249 3 234 75 224 201 19 124 9 204 148 62 5 250 189 219 161 178 175 79 36 192 216 255 240 236 243 126 2 10 182 65 111 41 138 163 2 165 48 112 122 122 10 189 125 0 28 105 6 180 253 152 0 251 211 17 96 59 65 68 192 185 217 251 252 220 109 56 110 58 193 99 102 14 218 65 18 64 115 55 186 193 18 240 5 30 159 152 76 31 234 247 186 143 0 222 32 28 90 160 6 47 46 46 192 187 168 240 128 234 104 56 212 111 254 18 176 114 63 1 23 13 218 13 197 24 78 199 227 57 140 241 51 66 232 18 210 27 126 111 95 216 222 1 39 96 192 8 0 226 1 19 111 127 132 128 238 112 79 45 152 203 13 58 2 184 7 84 71 22 238 20 9 25 76 31 59 244 199 55 26 141 199 221 93 96 236 218 31 19 2 176 66 146 128 212 37 128 203 155 62 176 238 42 119 4 84 180 189 238 112 77 28 0 159 169 30 48 15 72 221 6 27 125 38 116 12 166 242 183 238 206 94 49 136 214 39 79 113 243 114 3 39 192 50 80 171 205 161 170 166 22 43 196 122 28 44 116 73 87 39 39 124 101 28 110 212 254 140 140 140 140 140 61 199 179 103 241 242 82 204 109 19 152 91 78 242 182 83 249 116 247 75 123 155 250 210 137 109 178 221 229 216 147 86 158 116 251 54 161 201 225 210 178 82 127 96 250 212 209 251 154 206 182 78 216 38 125 219 246 66 9 85 229 25 24 153 40 242 114 60 244 113 200 129 86 121 114 208 5 114 65 42 42 191 221 216 175 16 3 122 103 3 54 211 68 35 155 177 9 5 151 150 155 243 209 89 80 155 96 174 236 238 237 165 225 118 130 207 233 115 128 231 204 126 19 40 157 122 251 77 108 222 101 191 124 117 184 8 204 20 252 81 191 30 97 133 42 125 158 43 84 159 204 13 178 3 128 250 147 186 82 127 198 249 237 88 11 99 34 43 42 159 12 78 144 108 244 159 78 251 20 4 104 99 191 70 116 14 135 60 78 43 59 45 125 232 216 140 88 116 217 149 36 128 165 195 160 94 156 191 124 117 118 142 134 141 42 237 223 126 192 39 69 192 95 224 175 250 53 194 6 234 210 49 147 113 242 161 115 227 1 42 159 82 5 219 96 222 79 206 146 246 158 57 17 245 3 35 120 52 213 28 52 194 129 27 177 57 232 35 160 237 5 188 172 207 254 223 224 153 87 72 219 143 134 236 210 30 240 149 250 90 253 221 15 41 93 48 15 184 96 30 112 193 60 160 181 223 157 193 26 154 78 170 203 111 89 123 223 52 210 55 157 130 54 153 199 185 3 152 62 192 219 151 38 224 197 249 23 135 250 21 182 191 141 212 49 1 37 216 81 39 39 127 5 223 234 215 63 156 108 218 195 215 184 149 43 38 163 114 123 253 106 184 78 145 19 224 178 187 174 15 160 230 52 252 41 12 218 203 195 96 168 78 1 231 139 140 128 46 189 11 219 223 173 136 160 4 32 249 252 235 199 163 199 255 252 174 149 143 220 225 14 151 147 167 244 236 41 113 9 180 50 22 159 63 247 178 241 253 110 188 51 72 128 98 208 27 204 248 96 239 125 16 216 32 247 151 173 194 254 46 96 150 24 241 245 6 29 129 250 143 167 236 112 113 89 49 251 101 2 95 98 251 213 203 239 117 247 55 249 254 101 43 78 205 245 95 70 246 23 134 182 221 40 234 68 129 84 19 131 252 44 14 224 195 222 76 14 125 3 76 76 158 114 251 249 109 80 53 139 186 124 177 157 17 120 232 138 165 7 49 140 99 133 251 138 120 32 68 65 98 160 140 140 140 140 140 29 96 136 7 166 77 40 7 23 177 234 55 188 180 208 78 69 68 239 126 60 118 92 9 37 44 244 251 2 223 154 47 1 133 154 159 195 112 248 195 15 240 29 82 231 17 222 127 126 6 47 94 192 217 220 201 108 189 133 27 110 112 227 13 157 204 55 116 201 27 143 155 198 48 26 14 95 19 6 184 189 171 17 48 213 199 26 163 108 19 52 3 11 30 141 159 250 200 235 95 6 255 246 161 232 98 168 15 48 21 201 77 87 206 166 106 217 31 109 242 234 235 232 208 177 210 201 142 159 28 108 10 124 114 101 2 227 5 188 230 227 13 138 200 171 16 96 66 45 180 135 177 221 254 118 21 46 105 232 249 230 141 82 111 222 120 125 134 10 234 41 158 217 225 4 144 37 35 96 7 163 208 130 135 82 53 67 21 29 1 186 170 25 143 65 4 188 50 115 117 184 193 133 97 189 143 0 224 26 8 115 89 121 51 187 231 61 106 97 101 111 127 73 235 55 159 126 242 245 173 46 26 161 112 21 6 108 65 6 221 223 206 131 162 10 96 18 79 157 207 41 236 1 147 9 94 175 62 158 207 77 122 233 9 208 246 43 52 4 198 25 231 201 66 88 100 46 142 195 77 122 254 203 118 205 136 235 3 190 181 211 207 240 182 171 80 215 100 127 56 137 19 112 172 255 60 54 63 174 216 56 216 16 78 145 7 16 253 42 120 245 234 232 213 28 46 187 3 190 54 218 141 54 71 0 247 128 31 173 236 70 229 90 251 189 129 227 133 197 41 221 221 19 166 79 233 201 201 9 33 160 249 108 197 83 141 115 253 211 17 208 104 179 232 237 3 230 115 115 1 224 78 240 245 112 56 218 96 39 8 180 15 48 246 47 60 3 198 254 154 164 163 115 163 239 169 223 125 241 8 46 17 3 230 64 199 168 219 115 131 55 206 190 167 79 219 159 86 238 6 68 250 250 128 97 53 159 207 97 142 25 0 118 27 220 244 93 224 185 25 152 245 250 240 212 109 49 153 248 1 43 221 3 234 159 210 51 0 228 195 253 121 232 54 240 219 160 245 8 139 158 62 64 223 117 53 48 1 18 235 17 192 80 218 115 255 220 197 1 129 53 130 164 3 49 61 198 235 18 61 167 7 112 253 162 32 42 129 194 75 86 6 149 25 210 171 220 130 141 213 227 128 221 227 248 221 187 99 36 78 31 25 174 52 7 141 40 250 88 185 114 50 35 35 35 99 45 12 241 234 232 179 159 76 23 243 211 217 206 180 217 62 222 3 188 239 132 159 93 175 251 243 14 53 218 46 158 24 115 159 180 194 89 115 199 49 239 222 7 102 48 195 59 252 39 16 204 168 21 6 166 19 152 89 254 103 233 138 155 194 123 147 64 57 23 248 224 9 248 208 213 96 97 67 40 142 168 61 37 98 234 129 111 224 50 204 204 61 29 173 134 222 110 156 242 164 49 248 9 106 156 135 30 66 159 146 111 168 189 83 36 22 110 26 249 227 224 35 157 157 21 205 109 147 0 221 3 152 20 250 61 105 156 234 48 193 19 99 202 218 239 167 23 141 221 200 254 208 210 221 105 57 197 246 125 212 111 31 73 133 217 14 9 168 221 249 174 113 227 84 135 154 93 242 0 87 37 46 195 246 135 8 40 137 203 216 133 230 93 122 219 92 240 120 143 10 102 179 217 246 34 93 111 176 215 39 117 18 208 228 171 181 157 116 138 107 123 192 118 59 65 235 0 205 67 51 214 134 119 158 128 119 168 82 127 31 95 35 247 177 88 187 15 16 12 222 40 120 167 247 210 139 47 113 37 182 19 18 232 249 87 27 184 11 168 254 197 8 155 199 204 27 220 104 112 237 196 107 95 73 246 1 88 138 249 199 39 98 167 201 250 47 102 88 22 222 254 178 75 29 246 105 180 34 35 35 35 35 35 227 134 81 67 76 188 105 192 136 5 50 116 233 232 13 224 224 128 202 53 143 172 182 76 0 48 10 8 1 182 172 196 21 234 81 105 222 72 5 147 50 59 121 210 84 234 79 111 107 22 59 215 162 24 236 12 217 182 96 245 195 22 82 2 154 178 78 103 123 122 180 121 188 2 33 0 151 75 2 120 178 8 162 178 17 183 231 5 109 236 63 65 27 40 1 118 248 163 85 210 126 140 176 206 109 5 76 192 40 96 19 111 47 33 110 242 255 7 164 176 109 15 88 138 128 45 123 192 118 251 0 142 157 247 1 91 190 11 128 32 100 199 119 129 61 192 110 227 128 140 140 140 140 140 251 141 248 115 100 119 29 229 127 21 252 122 142 214 110 234 40 229 242 30 125 79 174 121 142 20 126 173 209 243 12 227 250 109 224 1 10 23 155 240 239 63 88 85 222 59 44 224 127 154 0 133 86 39 43 19 251 11 6 128 127 86 159 38 239 27 74 184 82 234 215 90 93 225 167 173 23 167 58 163 165 207 215 122 67 6 39 3 253 211 45 223 134 19 186 158 221 200 64 229 129 121 13 246 52 188 173 218 117 243 151 254 12 141 167 96 86 219 147 7 119 16 1 246 171 209 138 35 247 253 122 80 64 81 152 13 78 62 50 47 255 253 123 166 92 111 41 142 246 148 0 235 1 26 87 248 140 155 126 97 129 51 120 76 192 119 13 58 23 95 81 222 59 140 236 61 112 138 214 188 232 100 116 8 167 195 30 2 238 92 39 56 6 184 186 188 194 221 126 51 28 225 83 82 80 219 29 161 218 54 198 239 245 249 121 127 43 159 154 207 200 200 200 200 88 27 252 249 128 148 204 23 81 173 42 175 218 222 186 114 10 252 249 128 148 204 151 209 173 42 175 218 222 186 114 10 103 208 225 108 25 153 47 164 92 85 94 181 189 117 229 36 248 243 1 31 252 1 156 124 109 98 195 235 86 110 150 210 218 242 119 157 12 92 86 189 229 31 124 249 135 222 246 21 68 203 205 138 78 86 78 229 230 16 254 121 135 24 192 55 0 157 236 14 162 218 217 224 235 107 60 59 156 170 47 203 69 125 63 69 30 42 199 179 103 225 79 32 250 168 223 126 251 141 232 103 254 156 47 57 191 6 174 30 54 152 202 230 234 189 102 10 99 133 68 125 37 12 138 215 103 4 36 245 81 238 183 71 158 55 246 111 142 128 41 250 14 186 0 1 161 207 85 12 74 182 31 240 144 152 7 152 111 27 153 3 44 79 64 250 18 48 223 190 21 81 40 237 242 192 228 20 129 16 59 158 98 245 185 172 25 152 119 245 147 224 207 7 4 58 53 215 9 250 78 140 119 82 192 229 254 78 53 216 73 242 246 121 39 75 203 29 63 125 178 185 6 58 57 137 109 223 198 214 189 141 174 42 167 177 237 64 102 221 64 106 85 57 141 109 135 178 235 134 210 171 202 25 25 25 25 25 25 25 17 180 129 195 141 201 123 15 246 255 3 211 242 29 36 0 226 4 216 151 151 125 246 237 100 70 128 226 255 244 112 191 209 124 37 33 68 100 70 16 184 183 62 153 253 251 187 125 71 246 128 123 223 7 220 247 187 64 70 70 70 70 70 70 198 166 81 220 158 72 32 185 10 18 170 213 23 186 22 236 255 3 237 51 10 149 208 117 9 2 248 249 190 77 246 111 194 3 184 189 183 202 126 234 1 118 121 187 125 161 109 21 251 119 122 60 216 55 245 21 149 239 110 31 80 57 248 114 198 87 107 255 237 241 129 117 61 160 169 175 176 124 171 236 95 215 3 110 189 253 235 222 5 122 236 191 179 125 64 2 222 254 219 227 3 73 15 88 5 198 110 247 155 145 177 231 248 63 201 230 115 28 31 60 117 80 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uiicons888888256x240Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 1 0 0 0 0 240 8 3 0 0 0 216 73 74 249 0 0 0 237 80 76 84 69 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 140 138 140 201 198 129 79 0 0 0 78 116 82 78 83 0 24 16 50 4 8 80 191 131 153 46 34 84 112 64 102 96 26 18 205 12 32 60 22 66 72 74 30 90 38 48 82 44 133 52 135 129 195 106 201 207 199 56 68 28 189 185 124 171 181 165 141 169 173 179 40 253 159 36 239 10 6 2 143 163 98 149 161 175 108 223 157 70 62 110 126 145 104 104 210 72 253 0 0 15 133 73 68 65 84 120 156 237 93 141 98 219 182 17 6 201 72 170 229 132 146 45 123 105 236 90 75 58 103 243 146 108 107 215 110 173 154 45 169 211 116 73 215 245 222 255 113 6 128 4 113 63 32 32 69 178 36 219 248 100 75 62 2 36 238 62 30 193 59 0 148 149 202 200 200 216 3 20 80 236 90 133 157 162 0 216 115 6 214 86 175 128 104 33 20 152 1 83 121 187 132 48 15 4 3 69 183 48 125 72 185 41 45 240 22 224 230 22 116 11 107 128 237 111 255 220 170 75 112 15 148 4 20 92 31 82 206 207 160 32 128 239 46 27 16 149 69 139 55 8 161 191 10 154 16 41 151 12 42 86 59 126 244 80 101 222 226 13 66 120 176 18 42 242 19 44 61 36 122 134 165 7 68 20 216 190 7 132 16 237 3 162 30 28 172 32 250 0 197 74 177 189 219 239 3 210 184 217 187 0 191 132 182 127 23 216 57 238 123 32 148 145 145 145 145 145 145 177 199 184 241 72 112 199 113 16 87 64 196 242 34 50 39 6 1 240 4 159 219 19 31 15 16 3 66 250 232 91 165 36 160 128 32 64 84 224 213 105 186 72 213 47 228 225 98 217 165 57 250 54 147 33 161 127 88 227 72 113 96 68 69 164 199 42 82 206 0 150 128 173 13 7 72 15 86 33 159 37 217 218 18 227 1 133 162 59 208 242 212 240 193 238 211 225 34 162 241 250 227 1 242 10 217 105 31 144 198 93 191 11 100 100 100 100 100 100 100 100 236 14 235 5 254 201 208 52 121 252 181 19 143 53 15 32 244 143 26 244 9 137 82 98 7 185 28 64 40 148 56 154 220 20 219 67 100 135 246 197 170 208 221 161 175 44 220 64 84 129 64 105 188 253 208 17 98 4 137 114 113 48 97 129 108 14 88 33 244 20 182 7 148 250 176 29 160 175 112 137 246 101 186 44 9 235 223 61 52 98 20 87 32 188 123 164 10 53 176 173 205 198 172 104 117 126 192 40 127 193 26 81 23 138 94 64 129 227 243 51 20 218 61 238 162 233 22 34 133 98 255 228 53 30 88 67 20 27 64 74 31 145 157 142 184 67 135 170 164 250 128 84 233 174 239 2 55 188 127 250 54 153 145 145 145 145 145 145 113 95 177 254 178 212 53 195 12 169 64 44 114 9 197 161 201 169 170 68 243 171 41 176 84 3 241 124 158 79 156 133 20 64 229 10 79 78 45 17 213 153 202 253 201 9 4 167 247 165 146 226 144 253 237 7 242 91 110 64 236 216 82 1 188 161 153 88 244 20 73 109 3 139 221 139 40 1 137 181 225 161 70 32 202 64 148 63 177 240 61 48 222 18 160 8 112 117 76 145 152 59 103 30 36 210 225 64 54 206 183 132 244 23 10 132 75 3 7 96 26 202 253 3 62 208 191 187 32 64 104 32 213 163 229 252 18 75 19 16 86 128 110 17 21 18 197 34 97 166 34 171 143 11 249 37 16 108 130 27 64 46 1 118 137 36 47 129 240 85 94 244 214 16 12 71 23 7 200 58 1 7 35 96 157 96 160 146 32 128 117 130 172 84 116 75 169 17 28 222 126 224 28 197 139 195 90 160 221 249 53 28 84 188 191 137 37 214 107 236 245 120 192 174 159 143 201 200 200 200 200 200 216 107 220 236 93 92 6 42 236 81 217 192 30 155 13 44 210 135 139 5 210 235 66 134 170 52 52 11 218 79 88 75 205 124 5 138 121 130 206 103 131 185 193 16 43 95 19 77 164 40 22 3 251 108 208 190 69 158 14 79 132 250 129 10 32 12 86 36 251 84 49 66 88 245 245 1 146 1 98 162 45 138 124 63 64 32 212 102 243 213 66 223 88 114 224 246 37 39 64 210 185 65 2 92 186 73 180 225 185 74 44 125 134 128 66 66 99 225 243 92 6 86 10 241 202 114 141 193 167 163 8 104 40 210 93 116 73 200 236 94 170 25 243 17 161 125 220 199 197 25 111 206 215 166 111 12 190 83 51 131 9 34 59 163 207 247 7 202 153 16 186 236 209 193 98 125 220 18 157 34 223 176 9 16 15 151 217 41 123 98 36 145 189 166 22 1 165 198 31 226 227 71 119 16 119 221 190 140 140 140 140 140 187 141 242 150 223 200 2 97 135 156 222 98 34 222 240 41 246 239 211 84 64 112 154 133 70 95 101 114 54 16 74 118 208 168 168 2 225 246 14 193 34 109 232 222 173 172 77 45 193 159 100 55 243 234 54 148 208 120 128 175 175 132 203 176 54 2 211 165 59 4 200 236 133 47 175 215 246 147 236 140 16 96 62 75 114 4 80 92 196 246 22 176 95 4 184 217 235 94 117 140 49 37 147 219 79 21 250 84 130 77 178 173 232 46 177 125 185 4 150 240 0 81 31 51 230 8 234 241 128 182 46 27 78 216 179 7 228 227 125 0 171 17 28 161 41 189 151 240 62 128 247 5 251 228 254 45 226 119 129 96 151 143 234 151 97 131 248 16 151 195 22 191 43 115 121 36 227 128 228 1 202 116 29 135 248 151 41 220 78 172 98 127 70 70 70 70 198 253 66 101 226 132 106 249 250 15 6 26 15 110 78 31 138 161 86 110 52 140 213 248 44 17 185 193 65 19 42 245 153 88 241 226 42 206 199 3 53 6 24 171 7 164 62 217 227 80 139 135 170 71 230 133 234 97 11 182 131 51 9 30 213 245 16 5 123 246 111 66 136 13 139 38 60 20 244 148 76 91 11 167 196 222 78 99 46 139 153 173 195 182 220 105 61 24 195 96 0 227 1 81 64 137 100 130 175 181 13 10 205 134 73 168 197 46 73 171 235 186 108 192 8 25 17 2 16 3 96 92 116 224 91 60 32 4 232 67 31 105 116 161 52 56 15 192 249 52 201 45 6 3 114 192 1 12 142 143 43 192 4 204 102 179 216 236 145 177 6 130 66 144 128 67 66 32 24 211 209 6 77 72 129 9 105 20 164 132 159 24 244 121 0 12 1 125 152 134 219 62 192 201 205 114 120 164 241 137 221 253 196 19 112 124 122 248 59 66 192 227 199 143 21 59 225 98 177 117 175 139 114 2 140 253 159 99 2 168 75 129 182 159 250 24 52 116 160 6 31 27 244 122 192 145 49 29 134 71 126 28 160 178 254 223 17 96 142 143 134 216 154 195 249 3 234 75 224 201 19 124 9 204 148 62 5 250 189 219 161 178 175 79 36 192 216 255 240 236 243 126 2 10 182 65 111 41 138 163 2 165 48 112 122 122 10 189 125 0 28 105 6 180 253 152 0 251 211 17 96 59 65 68 192 185 217 251 252 220 109 56 110 58 193 99 102 14 218 65 18 64 115 55 186 193 18 240 5 30 159 152 76 31 234 247 186 143 0 222 32 28 90 160 6 47 46 46 192 187 168 240 128 234 104 56 212 111 254 18 176 114 63 1 23 13 218 13 197 24 78 199 227 57 140 241 51 66 232 18 210 27 126 111 95 216 222 1 39 96 192 8 0 226 1 19 111 127 132 128 238 112 79 45 152 203 13 58 2 184 7 84 71 22 238 20 9 25 76 31 59 244 199 55 26 141 199 221 93 96 236 218 31 19 2 176 66 146 128 212 37 128 203 155 62 176 238 42 119 4 84 180 189 238 112 77 28 0 159 169 30 48 15 72 221 6 27 125 38 116 12 166 242 183 238 206 94 49 136 214 39 79 113 243 114 3 39 192 50 80 171 205 161 170 166 22 43 196 122 28 44 116 73 87 39 39 124 101 28 110 212 254 140 140 140 140 140 61 199 179 103 241 242 82 204 109 19 152 91 78 242 182 83 249 116 247 75 123 155 250 210 137 109 178 221 229 216 147 86 158 116 251 54 161 201 225 210 178 82 127 96 250 212 209 251 154 206 182 78 216 38 125 219 246 66 9 85 229 25 24 153 40 242 114 60 244 113 200 129 86 121 114 208 5 114 65 42 42 191 221 216 175 16 3 122 103 3 54 211 68 35 155 177 9 5 151 150 155 243 209 89 80 155 96 174 236 238 237 165 225 118 130 207 233 115 128 231 204 126 19 40 157 122 251 77 108 222 101 191 124 117 184 8 204 20 252 81 191 30 97 133 42 125 158 43 84 159 204 13 178 3 128 250 147 186 82 127 198 249 237 88 11 99 34 43 42 159 12 78 144 108 244 159 78 251 20 4 104 99 191 70 116 14 135 60 78 43 59 45 125 232 216 140 88 116 217 149 36 128 165 195 160 94 156 191 124 117 118 142 134 141 42 237 223 126 192 39 69 192 95 224 175 250 53 194 6 234 210 49 147 113 242 161 115 227 1 42 159 82 5 219 96 222 79 206 146 246 158 57 17 245 3 35 120 52 213 28 52 194 129 27 177 57 232 35 160 237 5 188 172 207 254 223 224 153 87 72 219 143 134 236 210 30 240 149 250 90 253 221 15 41 93 48 15 184 96 30 112 193 60 160 181 223 157 193 26 154 78 170 203 111 89 123 223 52 210 55 157 130 54 153 199 185 3 152 62 192 219 151 38 224 197 249 23 135 250 21 182 191 141 212 49 1 37 216 81 39 39 127 5 223 234 215 63 156 108 218 195 215 184 149 43 38 163 114 123 253 106 184 78 145 19 224 178 187 174 15 160 230 52 252 41 12 218 203 195 96 168 78 1 231 139 140 128 46 189 11 219 223 173 136 160 4 32 249 252 235 199 163 199 255 252 174 149 143 220 225 14 151 147 167 244 236 41 113 9 180 50 22 159 63 247 178 241 253 110 188 51 72 128 98 208 27 204 248 96 239 125 16 216 32 247 151 173 194 254 46 96 150 24 241 245 6 29 129 250 143 167 236 112 113 89 49 251 101 2 95 98 251 213 203 239 117 247 55 249 254 101 43 78 205 245 95 70 246 23 134 182 221 40 234 68 129 84 19 131 252 44 14 224 195 222 76 14 125 3 76 76 158 114 251 249 109 80 53 139 186 124 177 157 17 120 232 138 165 7 49 140 99 133 251 138 120 32 68 65 98 160 140 140 140 140 140 29 96 136 7 166 77 40 7 23 177 234 55 188 180 208 78 69 68 239 126 60 118 92 9 37 44 244 251 2 223 154 47 1 133 154 159 195 112 248 195 15 240 29 82 231 17 222 127 126 6 47 94 192 217 220 201 108 189 133 27 110 112 227 13 157 204 55 116 201 27 143 155 198 48 26 14 95 19 6 184 189 171 17 48 213 199 26 163 108 19 52 3 11 30 141 159 250 200 235 95 6 255 246 161 232 98 168 15 48 21 201 77 87 206 166 106 217 31 109 242 234 235 232 208 177 210 201 142 159 28 108 10 124 114 101 2 227 5 188 230 227 13 138 200 171 16 96 66 45 180 135 177 221 254 118 21 46 105 232 249 230 141 82 111 222 120 125 134 10 234 41 158 217 225 4 144 37 35 96 7 163 208 130 135 82 53 67 21 29 1 186 170 25 143 65 4 188 50 115 117 184 193 133 97 189 143 0 224 26 8 115 89 121 51 187 231 61 106 97 101 111 127 73 235 55 159 126 242 245 173 46 26 161 112 21 6 108 65 6 221 223 206 131 162 10 96 18 79 157 207 41 236 1 147 9 94 175 62 158 207 77 122 233 9 208 246 43 52 4 198 25 231 201 66 88 100 46 142 195 77 122 254 203 118 205 136 235 3 190 181 211 207 240 182 171 80 215 100 127 56 137 19 112 172 255 60 54 63 174 216 56 216 16 78 145 7 16 253 42 120 245 234 232 213 28 46 187 3 190 54 218 141 54 71 0 247 128 31 173 236 70 229 90 251 189 129 227 133 197 41 221 221 19 166 79 233 201 201 9 33 160 249 108 197 83 141 115 253 211 17 208 104 179 232 237 3 230 115 115 1 224 78 240 245 112 56 218 96 39 8 180 15 48 246 47 60 3 198 254 154 164 163 115 163 239 169 223 125 241 8 46 17 3 230 64 199 168 219 115 131 55 206 190 167 79 219 159 86 238 6 68 250 250 128 97 53 159 207 97 142 25 0 118 27 220 244 93 224 185 25 152 245 250 240 212 109 49 153 248 1 43 221 3 234 159 210 51 0 228 195 253 121 232 54 240 219 160 245 8 139 158 62 64 223 117 53 48 1 18 235 17 192 80 218 115 255 220 197 1 129 53 130 164 3 49 61 198 235 18 61 167 7 112 253 162 32 42 129 194 75 86 6 149 25 210 171 220 130 141 213 227 128 221 227 248 221 187 99 36 78 31 25 174 52 7 141 40 250 88 185 114 50 35 35 35 99 45 12 241 234 232 179 159 76 23 243 211 217 206 180 217 62 222 3 188 239 132 159 93 175 251 243 14 53 218 46 158 24 115 159 180 194 89 115 199 49 239 222 7 102 48 195 59 252 39 16 204 168 21 6 166 19 152 89 254 103 233 138 155 194 123 147 64 57 23 248 224 9 248 208 213 96 97 67 40 142 168 61 37 98 234 129 111 224 50 204 204 61 29 173 134 222 110 156 242 164 49 248 9 106 156 135 30 66 159 146 111 168 189 83 36 22 110 26 249 227 224 35 157 157 21 205 109 147 0 221 3 152 20 250 61 105 156 234 48 193 19 99 202 218 239 167 23 141 221 200 254 208 210 221 105 57 197 246 125 212 111 31 73 133 217 14 9 168 221 249 174 113 227 84 135 154 93 242 0 87 37 46 195 246 135 8 40 137 203 216 133 230 93 122 219 92 240 120 143 10 102 179 217 246 34 93 111 176 215 39 117 18 208 228 171 181 157 116 138 107 123 192 118 59 65 235 0 205 67 51 214 134 119 158 128 119 168 82 127 31 95 35 247 177 88 187 15 16 12 222 40 120 167 247 210 139 47 113 37 182 19 18 232 249 87 27 184 11 168 254 197 8 155 199 204 27 220 104 112 237 196 107 95 73 246 1 88 138 249 199 39 98 167 201 250 47 102 88 22 222 254 178 75 29 246 105 180 34 35 35 35 35 35 227 134 81 67 76 188 105 192 136 5 50 116 233 232 13 224 224 128 202 53 143 172 182 76 0 48 10 8 1 182 172 196 21 234 81 105 222 72 5 147 50 59 121 210 84 234 79 111 107 22 59 215 162 24 236 12 217 182 96 245 195 22 82 2 154 178 78 103 123 122 180 121 188 2 33 0 151 75 2 120 178 8 162 178 17 183 231 5 109 236 63 65 27 40 1 118 248 163 85 210 126 140 176 206 109 5 76 192 40 96 19 111 47 33 110 242 255 7 164 176 109 15 88 138 128 45 123 192 118 251 0 142 157 247 1 91 190 11 128 32 100 199 119 129 61 192 110 227 128 140 140 140 140 140 251 141 248 115 100 119 29 229 127 21 252 122 142 214 110 234 40 229 242 30 125 79 174 121 142 20 126 173 209 243 12 227 250 109 224 1 10 23 155 240 239 63 88 85 222 59 44 224 127 154 0 133 86 39 43 19 251 11 6 128 127 86 159 38 239 27 74 184 82 234 215 90 93 225 167 173 23 167 58 163 165 207 215 122 67 6 39 3 253 211 45 223 134 19 186 158 221 200 64 229 129 121 13 246 52 188 173 218 117 243 151 254 12 141 167 96 86 219 147 7 119 16 1 246 171 209 138 35 247 253 122 80 64 81 152 13 78 62 50 47 255 253 123 166 92 111 41 142 246 148 0 235 1 26 87 248 140 155 126 97 129 51 120 76 192 119 13 58 23 95 81 222 59 140 236 61 112 138 214 188 232 100 116 8 167 195 30 2 238 92 39 56 6 184 186 188 194 221 126 51 28 225 83 82 80 219 29 161 218 54 198 239 245 249 121 127 43 159 154 207 200 200 200 200 88 27 252 249 128 148 204 23 81 173 42 175 218 222 186 114 10 252 249 128 148 204 151 209 173 42 175 218 222 186 114 10 103 208 225 108 25 153 47 164 92 85 94 181 189 117 229 36 248 243 1 31 252 1 156 124 109 98 195 235 86 110 150 210 218 242 119 157 12 92 86 189 229 31 124 249 135 222 246 21 68 203 205 138 78 86 78 229 230 16 254 121 135 24 192 55 0 157 236 14 162 218 217 224 235 107 60 59 156 170 47 203 69 125 63 69 30 42 199 179 103 225 79 32 250 168 223 126 251 141 232 103 254 156 47 57 191 6 174 30 54 152 202 230 234 189 102 10 99 133 68 125 37 12 138 215 103 4 36 245 81 238 183 71 158 55 246 111 142 128 41 250 14 186 0 1 161 207 85 12 74 182 31 240 144 152 7 152 111 27 153 3 44 79 64 250 18 48 223 190 21 81 40 237 242 192 228 20 129 16 59 158 98 245 185 172 25 152 119 245 147 224 207 7 4 58 53 215 9 250 78 140 119 82 192 229 254 78 53 216 73 242 246 121 39 75 203 29 63 125 178 185 6 58 57 137 109 223 198 214 189 141 174 42 167 177 237 64 102 221 64 106 85 57 141 109 135 178 235 134 210 171 202 25 25 25 25 25 25 25 17 180 129 195 141 201 123 15 246 255 3 211 242 29 36 0 226 4 216 151 151 125 246 237 100 70 128 226 255 244 112 191 209 124 37 33 68 100 70 16 184 183 62 153 253 251 187 125 71 246 128 123 223 7 220 247 187 64 70 70 70 70 70 70 198 166 81 220 158 72 32 185 10 18 170 213 23 186 22 236 255 3 237 51 10 149 208 117 9 2 248 249 190 77 246 111 194 3 184 189 183 202 126 234 1 118 121 187 125 161 109 21 251 119 122 60 216 55 245 21 149 239 110 31 80 57 248 114 198 87 107 255 237 241 129 117 61 160 169 175 176 124 171 236 95 215 3 110 189 253 235 222 5 122 236 191 179 125 64 2 222 254 219 227 3 73 15 88 5 198 110 247 155 145 177 231 248 63 201 230 115 28 31 60 117 80 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uiiconscd0a0a256x240Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 1 0 0 0 0 240 8 3 0 0 0 216 73 74 249 0 0 0 237 80 76 84 69 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 204 10 12 235 14 70 99 0 0 0 78 116 82 78 83 0 24 16 50 4 8 80 191 131 153 46 34 84 112 64 102 96 26 18 205 12 32 60 22 66 72 74 30 90 38 48 82 44 133 52 135 129 195 106 201 207 199 56 68 28 189 185 124 171 181 165 141 169 173 179 40 253 159 36 239 10 6 2 143 163 98 149 161 175 108 223 157 70 62 110 126 145 104 104 210 72 253 0 0 15 133 73 68 65 84 120 156 237 93 141 98 219 182 17 6 201 72 170 229 132 146 45 123 105 236 90 75 58 103 243 146 108 107 215 110 173 154 45 169 211 116 73 215 245 222 255 113 6 128 4 113 63 32 32 69 178 36 219 248 100 75 62 2 36 238 62 30 193 59 0 148 149 202 200 200 216 3 20 80 236 90 133 157 162 0 216 115 6 214 86 175 128 104 33 20 152 1 83 121 187 132 48 15 4 3 69 183 48 125 72 185 41 45 240 22 224 230 22 116 11 107 128 237 111 255 220 170 75 112 15 148 4 20 92 31 82 206 207 160 32 128 239 46 27 16 149 69 139 55 8 161 191 10 154 16 41 151 12 42 86 59 126 244 80 101 222 226 13 66 120 176 18 42 242 19 44 61 36 122 134 165 7 68 20 216 190 7 132 16 237 3 162 30 28 172 32 250 0 197 74 177 189 219 239 3 210 184 217 187 0 191 132 182 127 23 216 57 238 123 32 148 145 145 145 145 145 145 177 199 184 241 72 112 199 113 16 87 64 196 242 34 50 39 6 1 240 4 159 219 19 31 15 16 3 66 250 232 91 165 36 160 128 32 64 84 224 213 105 186 72 213 47 228 225 98 217 165 57 250 54 147 33 161 127 88 227 72 113 96 68 69 164 199 42 82 206 0 150 128 173 13 7 72 15 86 33 159 37 217 218 18 227 1 133 162 59 208 242 212 240 193 238 211 225 34 162 241 250 227 1 242 10 217 105 31 144 198 93 191 11 100 100 100 100 100 100 100 100 236 14 235 5 254 201 208 52 121 252 181 19 143 53 15 32 244 143 26 244 9 137 82 98 7 185 28 64 40 148 56 154 220 20 219 67 100 135 246 197 170 208 221 161 175 44 220 64 84 129 64 105 188 253 208 17 98 4 137 114 113 48 97 129 108 14 88 33 244 20 182 7 148 250 176 29 160 175 112 137 246 101 186 44 9 235 223 61 52 98 20 87 32 188 123 164 10 53 176 173 205 198 172 104 117 126 192 40 127 193 26 81 23 138 94 64 129 227 243 51 20 218 61 238 162 233 22 34 133 98 255 228 53 30 88 67 20 27 64 74 31 145 157 142 184 67 135 170 164 250 128 84 233 174 239 2 55 188 127 250 54 153 145 145 145 145 145 145 113 95 177 254 178 212 53 195 12 169 64 44 114 9 197 161 201 169 170 68 243 171 41 176 84 3 241 124 158 79 156 133 20 64 229 10 79 78 45 17 213 153 202 253 201 9 4 167 247 165 146 226 144 253 237 7 242 91 110 64 236 216 82 1 188 161 153 88 244 20 73 109 3 139 221 139 40 1 137 181 225 161 70 32 202 64 148 63 177 240 61 48 222 18 160 8 112 117 76 145 152 59 103 30 36 210 225 64 54 206 183 132 244 23 10 132 75 3 7 96 26 202 253 3 62 208 191 187 32 64 104 32 213 163 229 252 18 75 19 16 86 128 110 17 21 18 197 34 97 166 34 171 143 11 249 37 16 108 130 27 64 46 1 118 137 36 47 129 240 85 94 244 214 16 12 71 23 7 200 58 1 7 35 96 157 96 160 146 32 128 117 130 172 84 116 75 169 17 28 222 126 224 28 197 139 195 90 160 221 249 53 28 84 188 191 137 37 214 107 236 245 120 192 174 159 143 201 200 200 200 200 200 216 107 220 236 93 92 6 42 236 81 217 192 30 155 13 44 210 135 139 5 210 235 66 134 170 52 52 11 218 79 88 75 205 124 5 138 121 130 206 103 131 185 193 16 43 95 19 77 164 40 22 3 251 108 208 190 69 158 14 79 132 250 129 10 32 12 86 36 251 84 49 66 88 245 245 1 146 1 98 162 45 138 124 63 64 32 212 102 243 213 66 223 88 114 224 246 37 39 64 210 185 65 2 92 186 73 180 225 185 74 44 125 134 128 66 66 99 225 243 92 6 86 10 241 202 114 141 193 167 163 8 104 40 210 93 116 73 200 236 94 170 25 243 17 161 125 220 199 197 25 111 206 215 166 111 12 190 83 51 131 9 34 59 163 207 247 7 202 153 16 186 236 209 193 98 125 220 18 157 34 223 176 9 16 15 151 217 41 123 98 36 145 189 166 22 1 165 198 31 226 227 71 119 16 119 221 190 140 140 140 140 140 187 141 242 150 223 200 2 97 135 156 222 98 34 222 240 41 246 239 211 84 64 112 154 133 70 95 101 114 54 16 74 118 208 168 168 2 225 246 14 193 34 109 232 222 173 172 77 45 193 159 100 55 243 234 54 148 208 120 128 175 175 132 203 176 54 2 211 165 59 4 200 236 133 47 175 215 246 147 236 140 16 96 62 75 114 4 80 92 196 246 22 176 95 4 184 217 235 94 117 140 49 37 147 219 79 21 250 84 130 77 178 173 232 46 177 125 185 4 150 240 0 81 31 51 230 8 234 241 128 182 46 27 78 216 179 7 228 227 125 0 171 17 28 161 41 189 151 240 62 128 247 5 251 228 254 45 226 119 129 96 151 143 234 151 97 131 248 16 151 195 22 191 43 115 121 36 227 128 228 1 202 116 29 135 248 151 41 220 78 172 98 127 70 70 70 70 198 253 66 101 226 132 106 249 250 15 6 26 15 110 78 31 138 161 86 110 52 140 213 248 44 17 185 193 65 19 42 245 153 88 241 226 42 206 199 3 53 6 24 171 7 164 62 217 227 80 139 135 170 71 230 133 234 97 11 182 131 51 9 30 213 245 16 5 123 246 111 66 136 13 139 38 60 20 244 148 76 91 11 167 196 222 78 99 46 139 153 173 195 182 220 105 61 24 195 96 0 227 1 81 64 137 100 130 175 181 13 10 205 134 73 168 197 46 73 171 235 186 108 192 8 25 17 2 16 3 96 92 116 224 91 60 32 4 232 67 31 105 116 161 52 56 15 192 249 52 201 45 6 3 114 192 1 12 142 143 43 192 4 204 102 179 216 236 145 177 6 130 66 144 128 67 66 32 24 211 209 6 77 72 129 9 105 20 164 132 159 24 244 121 0 12 1 125 152 134 219 62 192 201 205 114 120 164 241 137 221 253 196 19 112 124 122 248 59 66 192 227 199 143 21 59 225 98 177 117 175 139 114 2 140 253 159 99 2 168 75 129 182 159 250 24 52 116 160 6 31 27 244 122 192 145 49 29 134 71 126 28 160 178 254 223 17 96 142 143 134 216 154 195 249 3 234 75 224 201 19 124 9 204 148 62 5 250 189 219 161 178 175 79 36 192 216 255 240 236 243 126 2 10 182 65 111 41 138 163 2 165 48 112 122 122 10 189 125 0 28 105 6 180 253 152 0 251 211 17 96 59 65 68 192 185 217 251 252 220 109 56 110 58 193 99 102 14 218 65 18 64 115 55 186 193 18 240 5 30 159 152 76 31 234 247 186 143 0 222 32 28 90 160 6 47 46 46 192 187 168 240 128 234 104 56 212 111 254 18 176 114 63 1 23 13 218 13 197 24 78 199 227 57 140 241 51 66 232 18 210 27 126 111 95 216 222 1 39 96 192 8 0 226 1 19 111 127 132 128 238 112 79 45 152 203 13 58 2 184 7 84 71 22 238 20 9 25 76 31 59 244 199 55 26 141 199 221 93 96 236 218 31 19 2 176 66 146 128 212 37 128 203 155 62 176 238 42 119 4 84 180 189 238 112 77 28 0 159 169 30 48 15 72 221 6 27 125 38 116 12 166 242 183 238 206 94 49 136 214 39 79 113 243 114 3 39 192 50 80 171 205 161 170 166 22 43 196 122 28 44 116 73 87 39 39 124 101 28 110 212 254 140 140 140 140 140 61 199 179 103 241 242 82 204 109 19 152 91 78 242 182 83 249 116 247 75 123 155 250 210 137 109 178 221 229 216 147 86 158 116 251 54 161 201 225 210 178 82 127 96 250 212 209 251 154 206 182 78 216 38 125 219 246 66 9 85 229 25 24 153 40 242 114 60 244 113 200 129 86 121 114 208 5 114 65 42 42 191 221 216 175 16 3 122 103 3 54 211 68 35 155 177 9 5 151 150 155 243 209 89 80 155 96 174 236 238 237 165 225 118 130 207 233 115 128 231 204 126 19 40 157 122 251 77 108 222 101 191 124 117 184 8 204 20 252 81 191 30 97 133 42 125 158 43 84 159 204 13 178 3 128 250 147 186 82 127 198 249 237 88 11 99 34 43 42 159 12 78 144 108 244 159 78 251 20 4 104 99 191 70 116 14 135 60 78 43 59 45 125 232 216 140 88 116 217 149 36 128 165 195 160 94 156 191 124 117 118 142 134 141 42 237 223 126 192 39 69 192 95 224 175 250 53 194 6 234 210 49 147 113 242 161 115 227 1 42 159 82 5 219 96 222 79 206 146 246 158 57 17 245 3 35 120 52 213 28 52 194 129 27 177 57 232 35 160 237 5 188 172 207 254 223 224 153 87 72 219 143 134 236 210 30 240 149 250 90 253 221 15 41 93 48 15 184 96 30 112 193 60 160 181 223 157 193 26 154 78 170 203 111 89 123 223 52 210 55 157 130 54 153 199 185 3 152 62 192 219 151 38 224 197 249 23 135 250 21 182 191 141 212 49 1 37 216 81 39 39 127 5 223 234 215 63 156 108 218 195 215 184 149 43 38 163 114 123 253 106 184 78 145 19 224 178 187 174 15 160 230 52 252 41 12 218 203 195 96 168 78 1 231 139 140 128 46 189 11 219 223 173 136 160 4 32 249 252 235 199 163 199 255 252 174 149 143 220 225 14 151 147 167 244 236 41 113 9 180 50 22 159 63 247 178 241 253 110 188 51 72 128 98 208 27 204 248 96 239 125 16 216 32 247 151 173 194 254 46 96 150 24 241 245 6 29 129 250 143 167 236 112 113 89 49 251 101 2 95 98 251 213 203 239 117 247 55 249 254 101 43 78 205 245 95 70 246 23 134 182 221 40 234 68 129 84 19 131 252 44 14 224 195 222 76 14 125 3 76 76 158 114 251 249 109 80 53 139 186 124 177 157 17 120 232 138 165 7 49 140 99 133 251 138 120 32 68 65 98 160 140 140 140 140 140 29 96 136 7 166 77 40 7 23 177 234 55 188 180 208 78 69 68 239 126 60 118 92 9 37 44 244 251 2 223 154 47 1 133 154 159 195 112 248 195 15 240 29 82 231 17 222 127 126 6 47 94 192 217 220 201 108 189 133 27 110 112 227 13 157 204 55 116 201 27 143 155 198 48 26 14 95 19 6 184 189 171 17 48 213 199 26 163 108 19 52 3 11 30 141 159 250 200 235 95 6 255 246 161 232 98 168 15 48 21 201 77 87 206 166 106 217 31 109 242 234 235 232 208 177 210 201 142 159 28 108 10 124 114 101 2 227 5 188 230 227 13 138 200 171 16 96 66 45 180 135 177 221 254 118 21 46 105 232 249 230 141 82 111 222 120 125 134 10 234 41 158 217 225 4 144 37 35 96 7 163 208 130 135 82 53 67 21 29 1 186 170 25 143 65 4 188 50 115 117 184 193 133 97 189 143 0 224 26 8 115 89 121 51 187 231 61 106 97 101 111 127 73 235 55 159 126 242 245 173 46 26 161 112 21 6 108 65 6 221 223 206 131 162 10 96 18 79 157 207 41 236 1 147 9 94 175 62 158 207 77 122 233 9 208 246 43 52 4 198 25 231 201 66 88 100 46 142 195 77 122 254 203 118 205 136 235 3 190 181 211 207 240 182 171 80 215 100 127 56 137 19 112 172 255 60 54 63 174 216 56 216 16 78 145 7 16 253 42 120 245 234 232 213 28 46 187 3 190 54 218 141 54 71 0 247 128 31 173 236 70 229 90 251 189 129 227 133 197 41 221 221 19 166 79 233 201 201 9 33 160 249 108 197 83 141 115 253 211 17 208 104 179 232 237 3 230 115 115 1 224 78 240 245 112 56 218 96 39 8 180 15 48 246 47 60 3 198 254 154 164 163 115 163 239 169 223 125 241 8 46 17 3 230 64 199 168 219 115 131 55 206 190 167 79 219 159 86 238 6 68 250 250 128 97 53 159 207 97 142 25 0 118 27 220 244 93 224 185 25 152 245 250 240 212 109 49 153 248 1 43 221 3 234 159 210 51 0 228 195 253 121 232 54 240 219 160 245 8 139 158 62 64 223 117 53 48 1 18 235 17 192 80 218 115 255 220 197 1 129 53 130 164 3 49 61 198 235 18 61 167 7 112 253 162 32 42 129 194 75 86 6 149 25 210 171 220 130 141 213 227 128 221 227 248 221 187 99 36 78 31 25 174 52 7 141 40 250 88 185 114 50 35 35 35 99 45 12 241 234 232 179 159 76 23 243 211 217 206 180 217 62 222 3 188 239 132 159 93 175 251 243 14 53 218 46 158 24 115 159 180 194 89 115 199 49 239 222 7 102 48 195 59 252 39 16 204 168 21 6 166 19 152 89 254 103 233 138 155 194 123 147 64 57 23 248 224 9 248 208 213 96 97 67 40 142 168 61 37 98 234 129 111 224 50 204 204 61 29 173 134 222 110 156 242 164 49 248 9 106 156 135 30 66 159 146 111 168 189 83 36 22 110 26 249 227 224 35 157 157 21 205 109 147 0 221 3 152 20 250 61 105 156 234 48 193 19 99 202 218 239 167 23 141 221 200 254 208 210 221 105 57 197 246 125 212 111 31 73 133 217 14 9 168 221 249 174 113 227 84 135 154 93 242 0 87 37 46 195 246 135 8 40 137 203 216 133 230 93 122 219 92 240 120 143 10 102 179 217 246 34 93 111 176 215 39 117 18 208 228 171 181 157 116 138 107 123 192 118 59 65 235 0 205 67 51 214 134 119 158 128 119 168 82 127 31 95 35 247 177 88 187 15 16 12 222 40 120 167 247 210 139 47 113 37 182 19 18 232 249 87 27 184 11 168 254 197 8 155 199 204 27 220 104 112 237 196 107 95 73 246 1 88 138 249 199 39 98 167 201 250 47 102 88 22 222 254 178 75 29 246 105 180 34 35 35 35 35 35 227 134 81 67 76 188 105 192 136 5 50 116 233 232 13 224 224 128 202 53 143 172 182 76 0 48 10 8 1 182 172 196 21 234 81 105 222 72 5 147 50 59 121 210 84 234 79 111 107 22 59 215 162 24 236 12 217 182 96 245 195 22 82 2 154 178 78 103 123 122 180 121 188 2 33 0 151 75 2 120 178 8 162 178 17 183 231 5 109 236 63 65 27 40 1 118 248 163 85 210 126 140 176 206 109 5 76 192 40 96 19 111 47 33 110 242 255 7 164 176 109 15 88 138 128 45 123 192 118 251 0 142 157 247 1 91 190 11 128 32 100 199 119 129 61 192 110 227 128 140 140 140 140 140 251 141 248 115 100 119 29 229 127 21 252 122 142 214 110 234 40 229 242 30 125 79 174 121 142 20 126 173 209 243 12 227 250 109 224 1 10 23 155 240 239 63 88 85 222 59 44 224 127 154 0 133 86 39 43 19 251 11 6 128 127 86 159 38 239 27 74 184 82 234 215 90 93 225 167 173 23 167 58 163 165 207 215 122 67 6 39 3 253 211 45 223 134 19 186 158 221 200 64 229 129 121 13 246 52 188 173 218 117 243 151 254 12 141 167 96 86 219 147 7 119 16 1 246 171 209 138 35 247 253 122 80 64 81 152 13 78 62 50 47 255 253 123 166 92 111 41 142 246 148 0 235 1 26 87 248 140 155 126 97 129 51 120 76 192 119 13 58 23 95 81 222 59 140 236 61 112 138 214 188 232 100 116 8 167 195 30 2 238 92 39 56 6 184 186 188 194 221 126 51 28 225 83 82 80 219 29 161 218 54 198 239 245 249 121 127 43 159 154 207 200 200 200 200 88 27 252 249 128 148 204 23 81 173 42 175 218 222 186 114 10 252 249 128 148 204 151 209 173 42 175 218 222 186 114 10 103 208 225 108 25 153 47 164 92 85 94 181 189 117 229 36 248 243 1 31 252 1 156 124 109 98 195 235 86 110 150 210 218 242 119 157 12 92 86 189 229 31 124 249 135 222 246 21 68 203 205 138 78 86 78 229 230 16 254 121 135 24 192 55 0 157 236 14 162 218 217 224 235 107 60 59 156 170 47 203 69 125 63 69 30 42 199 179 103 225 79 32 250 168 223 126 251 141 232 103 254 156 47 57 191 6 174 30 54 152 202 230 234 189 102 10 99 133 68 125 37 12 138 215 103 4 36 245 81 238 183 71 158 55 246 111 142 128 41 250 14 186 0 1 161 207 85 12 74 182 31 240 144 152 7 152 111 27 153 3 44 79 64 250 18 48 223 190 21 81 40 237 242 192 228 20 129 16 59 158 98 245 185 172 25 152 119 245 147 224 207 7 4 58 53 215 9 250 78 140 119 82 192 229 254 78 53 216 73 242 246 121 39 75 203 29 63 125 178 185 6 58 57 137 109 223 198 214 189 141 174 42 167 177 237 64 102 221 64 106 85 57 141 109 135 178 235 134 210 171 202 25 25 25 25 25 25 25 17 180 129 195 141 201 123 15 246 255 3 211 242 29 36 0 226 4 216 151 151 125 246 237 100 70 128 226 255 244 112 191 209 124 37 33 68 100 70 16 184 183 62 153 253 251 187 125 71 246 128 123 223 7 220 247 187 64 70 70 70 70 70 70 198 166 81 220 158 72 32 185 10 18 170 213 23 186 22 236 255 3 237 51 10 149 208 117 9 2 248 249 190 77 246 111 194 3 184 189 183 202 126 234 1 118 121 187 125 161 109 21 251 119 122 60 216 55 245 21 149 239 110 31 80 57 248 114 198 87 107 255 237 241 129 117 61 160 169 175 176 124 171 236 95 215 3 110 189 253 235 222 5 122 236 191 179 125 64 2 222 254 219 227 3 73 15 88 5 198 110 247 155 145 177 231 248 63 201 230 115 28 31 60 117 80 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #uploaded }
JQSGLTheme >> uiiconsffffff256x240Png [
	^ #(137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 1 0 0 0 0 240 8 3 0 0 0 216 73 74 249 0 0 0 237 80 76 84 69 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 252 254 252 176 11 127 188 0 0 0 78 116 82 78 83 0 24 16 50 4 8 80 191 131 153 46 34 84 112 64 102 96 26 18 205 12 32 60 22 66 72 74 30 90 38 48 82 44 133 52 135 129 195 106 201 207 199 56 68 28 189 185 124 171 181 165 141 169 173 179 40 253 159 36 239 10 6 2 143 163 98 149 161 175 108 223 157 70 62 110 126 145 104 104 210 72 253 0 0 15 133 73 68 65 84 120 156 237 93 141 98 219 182 17 6 201 72 170 229 132 146 45 123 105 236 90 75 58 103 243 146 108 107 215 110 173 154 45 169 211 116 73 215 245 222 255 113 6 128 4 113 63 32 32 69 178 36 219 248 100 75 62 2 36 238 62 30 193 59 0 148 149 202 200 200 216 3 20 80 236 90 133 157 162 0 216 115 6 214 86 175 128 104 33 20 152 1 83 121 187 132 48 15 4 3 69 183 48 125 72 185 41 45 240 22 224 230 22 116 11 107 128 237 111 255 220 170 75 112 15 148 4 20 92 31 82 206 207 160 32 128 239 46 27 16 149 69 139 55 8 161 191 10 154 16 41 151 12 42 86 59 126 244 80 101 222 226 13 66 120 176 18 42 242 19 44 61 36 122 134 165 7 68 20 216 190 7 132 16 237 3 162 30 28 172 32 250 0 197 74 177 189 219 239 3 210 184 217 187 0 191 132 182 127 23 216 57 238 123 32 148 145 145 145 145 145 145 177 199 184 241 72 112 199 113 16 87 64 196 242 34 50 39 6 1 240 4 159 219 19 31 15 16 3 66 250 232 91 165 36 160 128 32 64 84 224 213 105 186 72 213 47 228 225 98 217 165 57 250 54 147 33 161 127 88 227 72 113 96 68 69 164 199 42 82 206 0 150 128 173 13 7 72 15 86 33 159 37 217 218 18 227 1 133 162 59 208 242 212 240 193 238 211 225 34 162 241 250 227 1 242 10 217 105 31 144 198 93 191 11 100 100 100 100 100 100 100 100 236 14 235 5 254 201 208 52 121 252 181 19 143 53 15 32 244 143 26 244 9 137 82 98 7 185 28 64 40 148 56 154 220 20 219 67 100 135 246 197 170 208 221 161 175 44 220 64 84 129 64 105 188 253 208 17 98 4 137 114 113 48 97 129 108 14 88 33 244 20 182 7 148 250 176 29 160 175 112 137 246 101 186 44 9 235 223 61 52 98 20 87 32 188 123 164 10 53 176 173 205 198 172 104 117 126 192 40 127 193 26 81 23 138 94 64 129 227 243 51 20 218 61 238 162 233 22 34 133 98 255 228 53 30 88 67 20 27 64 74 31 145 157 142 184 67 135 170 164 250 128 84 233 174 239 2 55 188 127 250 54 153 145 145 145 145 145 145 113 95 177 254 178 212 53 195 12 169 64 44 114 9 197 161 201 169 170 68 243 171 41 176 84 3 241 124 158 79 156 133 20 64 229 10 79 78 45 17 213 153 202 253 201 9 4 167 247 165 146 226 144 253 237 7 242 91 110 64 236 216 82 1 188 161 153 88 244 20 73 109 3 139 221 139 40 1 137 181 225 161 70 32 202 64 148 63 177 240 61 48 222 18 160 8 112 117 76 145 152 59 103 30 36 210 225 64 54 206 183 132 244 23 10 132 75 3 7 96 26 202 253 3 62 208 191 187 32 64 104 32 213 163 229 252 18 75 19 16 86 128 110 17 21 18 197 34 97 166 34 171 143 11 249 37 16 108 130 27 64 46 1 118 137 36 47 129 240 85 94 244 214 16 12 71 23 7 200 58 1 7 35 96 157 96 160 146 32 128 117 130 172 84 116 75 169 17 28 222 126 224 28 197 139 195 90 160 221 249 53 28 84 188 191 137 37 214 107 236 245 120 192 174 159 143 201 200 200 200 200 200 216 107 220 236 93 92 6 42 236 81 217 192 30 155 13 44 210 135 139 5 210 235 66 134 170 52 52 11 218 79 88 75 205 124 5 138 121 130 206 103 131 185 193 16 43 95 19 77 164 40 22 3 251 108 208 190 69 158 14 79 132 250 129 10 32 12 86 36 251 84 49 66 88 245 245 1 146 1 98 162 45 138 124 63 64 32 212 102 243 213 66 223 88 114 224 246 37 39 64 210 185 65 2 92 186 73 180 225 185 74 44 125 134 128 66 66 99 225 243 92 6 86 10 241 202 114 141 193 167 163 8 104 40 210 93 116 73 200 236 94 170 25 243 17 161 125 220 199 197 25 111 206 215 166 111 12 190 83 51 131 9 34 59 163 207 247 7 202 153 16 186 236 209 193 98 125 220 18 157 34 223 176 9 16 15 151 217 41 123 98 36 145 189 166 22 1 165 198 31 226 227 71 119 16 119 221 190 140 140 140 140 140 187 141 242 150 223 200 2 97 135 156 222 98 34 222 240 41 246 239 211 84 64 112 154 133 70 95 101 114 54 16 74 118 208 168 168 2 225 246 14 193 34 109 232 222 173 172 77 45 193 159 100 55 243 234 54 148 208 120 128 175 175 132 203 176 54 2 211 165 59 4 200 236 133 47 175 215 246 147 236 140 16 96 62 75 114 4 80 92 196 246 22 176 95 4 184 217 235 94 117 140 49 37 147 219 79 21 250 84 130 77 178 173 232 46 177 125 185 4 150 240 0 81 31 51 230 8 234 241 128 182 46 27 78 216 179 7 228 227 125 0 171 17 28 161 41 189 151 240 62 128 247 5 251 228 254 45 226 119 129 96 151 143 234 151 97 131 248 16 151 195 22 191 43 115 121 36 227 128 228 1 202 116 29 135 248 151 41 220 78 172 98 127 70 70 70 70 198 253 66 101 226 132 106 249 250 15 6 26 15 110 78 31 138 161 86 110 52 140 213 248 44 17 185 193 65 19 42 245 153 88 241 226 42 206 199 3 53 6 24 171 7 164 62 217 227 80 139 135 170 71 230 133 234 97 11 182 131 51 9 30 213 245 16 5 123 246 111 66 136 13 139 38 60 20 244 148 76 91 11 167 196 222 78 99 46 139 153 173 195 182 220 105 61 24 195 96 0 227 1 81 64 137 100 130 175 181 13 10 205 134 73 168 197 46 73 171 235 186 108 192 8 25 17 2 16 3 96 92 116 224 91 60 32 4 232 67 31 105 116 161 52 56 15 192 249 52 201 45 6 3 114 192 1 12 142 143 43 192 4 204 102 179 216 236 145 177 6 130 66 144 128 67 66 32 24 211 209 6 77 72 129 9 105 20 164 132 159 24 244 121 0 12 1 125 152 134 219 62 192 201 205 114 120 164 241 137 221 253 196 19 112 124 122 248 59 66 192 227 199 143 21 59 225 98 177 117 175 139 114 2 140 253 159 99 2 168 75 129 182 159 250 24 52 116 160 6 31 27 244 122 192 145 49 29 134 71 126 28 160 178 254 223 17 96 142 143 134 216 154 195 249 3 234 75 224 201 19 124 9 204 148 62 5 250 189 219 161 178 175 79 36 192 216 255 240 236 243 126 2 10 182 65 111 41 138 163 2 165 48 112 122 122 10 189 125 0 28 105 6 180 253 152 0 251 211 17 96 59 65 68 192 185 217 251 252 220 109 56 110 58 193 99 102 14 218 65 18 64 115 55 186 193 18 240 5 30 159 152 76 31 234 247 186 143 0 222 32 28 90 160 6 47 46 46 192 187 168 240 128 234 104 56 212 111 254 18 176 114 63 1 23 13 218 13 197 24 78 199 227 57 140 241 51 66 232 18 210 27 126 111 95 216 222 1 39 96 192 8 0 226 1 19 111 127 132 128 238 112 79 45 152 203 13 58 2 184 7 84 71 22 238 20 9 25 76 31 59 244 199 55 26 141 199 221 93 96 236 218 31 19 2 176 66 146 128 212 37 128 203 155 62 176 238 42 119 4 84 180 189 238 112 77 28 0 159 169 30 48 15 72 221 6 27 125 38 116 12 166 242 183 238 206 94 49 136 214 39 79 113 243 114 3 39 192 50 80 171 205 161 170 166 22 43 196 122 28 44 116 73 87 39 39 124 101 28 110 212 254 140 140 140 140 140 61 199 179 103 241 242 82 204 109 19 152 91 78 242 182 83 249 116 247 75 123 155 250 210 137 109 178 221 229 216 147 86 158 116 251 54 161 201 225 210 178 82 127 96 250 212 209 251 154 206 182 78 216 38 125 219 246 66 9 85 229 25 24 153 40 242 114 60 244 113 200 129 86 121 114 208 5 114 65 42 42 191 221 216 175 16 3 122 103 3 54 211 68 35 155 177 9 5 151 150 155 243 209 89 80 155 96 174 236 238 237 165 225 118 130 207 233 115 128 231 204 126 19 40 157 122 251 77 108 222 101 191 124 117 184 8 204 20 252 81 191 30 97 133 42 125 158 43 84 159 204 13 178 3 128 250 147 186 82 127 198 249 237 88 11 99 34 43 42 159 12 78 144 108 244 159 78 251 20 4 104 99 191 70 116 14 135 60 78 43 59 45 125 232 216 140 88 116 217 149 36 128 165 195 160 94 156 191 124 117 118 142 134 141 42 237 223 126 192 39 69 192 95 224 175 250 53 194 6 234 210 49 147 113 242 161 115 227 1 42 159 82 5 219 96 222 79 206 146 246 158 57 17 245 3 35 120 52 213 28 52 194 129 27 177 57 232 35 160 237 5 188 172 207 254 223 224 153 87 72 219 143 134 236 210 30 240 149 250 90 253 221 15 41 93 48 15 184 96 30 112 193 60 160 181 223 157 193 26 154 78 170 203 111 89 123 223 52 210 55 157 130 54 153 199 185 3 152 62 192 219 151 38 224 197 249 23 135 250 21 182 191 141 212 49 1 37 216 81 39 39 127 5 223 234 215 63 156 108 218 195 215 184 149 43 38 163 114 123 253 106 184 78 145 19 224 178 187 174 15 160 230 52 252 41 12 218 203 195 96 168 78 1 231 139 140 128 46 189 11 219 223 173 136 160 4 32 249 252 235 199 163 199 255 252 174 149 143 220 225 14 151 147 167 244 236 41 113 9 180 50 22 159 63 247 178 241 253 110 188 51 72 128 98 208 27 204 248 96 239 125 16 216 32 247 151 173 194 254 46 96 150 24 241 245 6 29 129 250 143 167 236 112 113 89 49 251 101 2 95 98 251 213 203 239 117 247 55 249 254 101 43 78 205 245 95 70 246 23 134 182 221 40 234 68 129 84 19 131 252 44 14 224 195 222 76 14 125 3 76 76 158 114 251 249 109 80 53 139 186 124 177 157 17 120 232 138 165 7 49 140 99 133 251 138 120 32 68 65 98 160 140 140 140 140 140 29 96 136 7 166 77 40 7 23 177 234 55 188 180 208 78 69 68 239 126 60 118 92 9 37 44 244 251 2 223 154 47 1 133 154 159 195 112 248 195 15 240 29 82 231 17 222 127 126 6 47 94 192 217 220 201 108 189 133 27 110 112 227 13 157 204 55 116 201 27 143 155 198 48 26 14 95 19 6 184 189 171 17 48 213 199 26 163 108 19 52 3 11 30 141 159 250 200 235 95 6 255 246 161 232 98 168 15 48 21 201 77 87 206 166 106 217 31 109 242 234 235 232 208 177 210 201 142 159 28 108 10 124 114 101 2 227 5 188 230 227 13 138 200 171 16 96 66 45 180 135 177 221 254 118 21 46 105 232 249 230 141 82 111 222 120 125 134 10 234 41 158 217 225 4 144 37 35 96 7 163 208 130 135 82 53 67 21 29 1 186 170 25 143 65 4 188 50 115 117 184 193 133 97 189 143 0 224 26 8 115 89 121 51 187 231 61 106 97 101 111 127 73 235 55 159 126 242 245 173 46 26 161 112 21 6 108 65 6 221 223 206 131 162 10 96 18 79 157 207 41 236 1 147 9 94 175 62 158 207 77 122 233 9 208 246 43 52 4 198 25 231 201 66 88 100 46 142 195 77 122 254 203 118 205 136 235 3 190 181 211 207 240 182 171 80 215 100 127 56 137 19 112 172 255 60 54 63 174 216 56 216 16 78 145 7 16 253 42 120 245 234 232 213 28 46 187 3 190 54 218 141 54 71 0 247 128 31 173 236 70 229 90 251 189 129 227 133 197 41 221 221 19 166 79 233 201 201 9 33 160 249 108 197 83 141 115 253 211 17 208 104 179 232 237 3 230 115 115 1 224 78 240 245 112 56 218 96 39 8 180 15 48 246 47 60 3 198 254 154 164 163 115 163 239 169 223 125 241 8 46 17 3 230 64 199 168 219 115 131 55 206 190 167 79 219 159 86 238 6 68 250 250 128 97 53 159 207 97 142 25 0 118 27 220 244 93 224 185 25 152 245 250 240 212 109 49 153 248 1 43 221 3 234 159 210 51 0 228 195 253 121 232 54 240 219 160 245 8 139 158 62 64 223 117 53 48 1 18 235 17 192 80 218 115 255 220 197 1 129 53 130 164 3 49 61 198 235 18 61 167 7 112 253 162 32 42 129 194 75 86 6 149 25 210 171 220 130 141 213 227 128 221 227 248 221 187 99 36 78 31 25 174 52 7 141 40 250 88 185 114 50 35 35 35 99 45 12 241 234 232 179 159 76 23 243 211 217 206 180 217 62 222 3 188 239 132 159 93 175 251 243 14 53 218 46 158 24 115 159 180 194 89 115 199 49 239 222 7 102 48 195 59 252 39 16 204 168 21 6 166 19 152 89 254 103 233 138 155 194 123 147 64 57 23 248 224 9 248 208 213 96 97 67 40 142 168 61 37 98 234 129 111 224 50 204 204 61 29 173 134 222 110 156 242 164 49 248 9 106 156 135 30 66 159 146 111 168 189 83 36 22 110 26 249 227 224 35 157 157 21 205 109 147 0 221 3 152 20 250 61 105 156 234 48 193 19 99 202 218 239 167 23 141 221 200 254 208 210 221 105 57 197 246 125 212 111 31 73 133 217 14 9 168 221 249 174 113 227 84 135 154 93 242 0 87 37 46 195 246 135 8 40 137 203 216 133 230 93 122 219 92 240 120 143 10 102 179 217 246 34 93 111 176 215 39 117 18 208 228 171 181 157 116 138 107 123 192 118 59 65 235 0 205 67 51 214 134 119 158 128 119 168 82 127 31 95 35 247 177 88 187 15 16 12 222 40 120 167 247 210 139 47 113 37 182 19 18 232 249 87 27 184 11 168 254 197 8 155 199 204 27 220 104 112 237 196 107 95 73 246 1 88 138 249 199 39 98 167 201 250 47 102 88 22 222 254 178 75 29 246 105 180 34 35 35 35 35 35 227 134 81 67 76 188 105 192 136 5 50 116 233 232 13 224 224 128 202 53 143 172 182 76 0 48 10 8 1 182 172 196 21 234 81 105 222 72 5 147 50 59 121 210 84 234 79 111 107 22 59 215 162 24 236 12 217 182 96 245 195 22 82 2 154 178 78 103 123 122 180 121 188 2 33 0 151 75 2 120 178 8 162 178 17 183 231 5 109 236 63 65 27 40 1 118 248 163 85 210 126 140 176 206 109 5 76 192 40 96 19 111 47 33 110 242 255 7 164 176 109 15 88 138 128 45 123 192 118 251 0 142 157 247 1 91 190 11 128 32 100 199 119 129 61 192 110 227 128 140 140 140 140 140 251 141 248 115 100 119 29 229 127 21 252 122 142 214 110 234 40 229 242 30 125 79 174 121 142 20 126 173 209 243 12 227 250 109 224 1 10 23 155 240 239 63 88 85 222 59 44 224 127 154 0 133 86 39 43 19 251 11 6 128 127 86 159 38 239 27 74 184 82 234 215 90 93 225 167 173 23 167 58 163 165 207 215 122 67 6 39 3 253 211 45 223 134 19 186 158 221 200 64 229 129 121 13 246 52 188 173 218 117 243 151 254 12 141 167 96 86 219 147 7 119 16 1 246 171 209 138 35 247 253 122 80 64 81 152 13 78 62 50 47 255 253 123 166 92 111 41 142 246 148 0 235 1 26 87 248 140 155 126 97 129 51 120 76 192 119 13 58 23 95 81 222 59 140 236 61 112 138 214 188 232 100 116 8 167 195 30 2 238 92 39 56 6 184 186 188 194 221 126 51 28 225 83 82 80 219 29 161 218 54 198 239 245 249 121 127 43 159 154 207 200 200 200 200 88 27 252 249 128 148 204 23 81 173 42 175 218 222 186 114 10 252 249 128 148 204 151 209 173 42 175 218 222 186 114 10 103 208 225 108 25 153 47 164 92 85 94 181 189 117 229 36 248 243 1 31 252 1 156 124 109 98 195 235 86 110 150 210 218 242 119 157 12 92 86 189 229 31 124 249 135 222 246 21 68 203 205 138 78 86 78 229 230 16 254 121 135 24 192 55 0 157 236 14 162 218 217 224 235 107 60 59 156 170 47 203 69 125 63 69 30 42 199 179 103 225 79 32 250 168 223 126 251 141 232 103 254 156 47 57 191 6 174 30 54 152 202 230 234 189 102 10 99 133 68 125 37 12 138 215 103 4 36 245 81 238 183 71 158 55 246 111 142 128 41 250 14 186 0 1 161 207 85 12 74 182 31 240 144 152 7 152 111 27 153 3 44 79 64 250 18 48 223 190 21 81 40 237 242 192 228 20 129 16 59 158 98 245 185 172 25 152 119 245 147 224 207 7 4 58 53 215 9 250 78 140 119 82 192 229 254 78 53 216 73 242 246 121 39 75 203 29 63 125 178 185 6 58 57 137 109 223 198 214 189 141 174 42 167 177 237 64 102 221 64 106 85 57 141 109 135 178 235 134 210 171 202 25 25 25 25 25 25 25 17 180 129 195 141 201 123 15 246 255 3 211 242 29 36 0 226 4 216 151 151 125 246 237 100 70 128 226 255 244 112 191 209 124 37 33 68 100 70 16 184 183 62 153 253 251 187 125 71 246 128 123 223 7 220 247 187 64 70 70 70 70 70 70 198 166 81 220 158 72 32 185 10 18 170 213 23 186 22 236 255 3 237 51 10 149 208 117 9 2 248 249 190 77 246 111 194 3 184 189 183 202 126 234 1 118 121 187 125 161 109 21 251 119 122 60 216 55 245 21 149 239 110 31 80 57 248 114 198 87 107 255 237 241 129 117 61 160 169 175 176 124 171 236 95 215 3 110 189 253 235 222 5 122 236 191 179 125 64 2 222 254 219 227 3 73 15 88 5 198 110 247 155 145 177 231 248 63 201 230 115 28 31 60 117 80 0 0 0 0 73 69 78 68 174 66 96 130) asByteArray
]

{ #category : #updating }
JQSGLTheme >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (self class urlOf: #glamourThemeJQueryUICss).
]
