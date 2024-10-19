#!/bin/bash
#@(#) given a topic string for current man(1) path build document
export MANPATH=$(dirname $0)/../../man
####################################################################################################################################
INDX(){
#set -x
export TOPIC="$1" NAME
export SECTION="$2"
export TOPHTML=${TOPHTML:-../docs}
export MAN_CMD=${MAN_CMD:-man}
HTML >$TOPHTML/BOOK_$TOPIC.html
(
   echo 'function loadthem(){'
   if [ "$TOPIC" = 'INDEX' ]
   then
      (
         cd $TOPHTML
         # make sure sort(1) does not sort case-insensitive
         find . -type f -name 'BOOK_*.html' |env LC_ALL=C /usr/bin/sort
      )
   else
      # make sure sort(1) does not sort case-insensitive
      (
        echo "$TOPIC.3${SECTION}.html"
	# put section 3 topics first
        $MAN_CMD -s "3${SECTION}" -k .|env LC_ALL=C /usr/bin/sort -k 2r,2r -k 1,1|grep -i  "(3${TOPIC})"
	# put non-section 3 topics next
        $MAN_CMD -s "5{$SECTION}" -k .|env LC_ALL=C /usr/bin/sort -k 2r,2r -k 1,1|grep -vi "(5${TOPIC})"
        $MAN_CMD -s "7{$SECTION}" -k .|env LC_ALL=C /usr/bin/sort -k 2r,2r -k 1,1|grep -vi "(7${TOPIC})"
      )|tr -d '()'| awk '{printf "%s.%s.html\n",$1,$2}'
   fi| uniq|while read NAME
   do
      if [ -r "$TOPHTML/$NAME" ]
      then
         echo "append(\"$NAME\");"
      fi
   done
   echo '}'
) > $TOPHTML/$TOPIC.js
}
####################################################################################################################################
HTML(){
cat <<\EOF
<html>
<head>
<meta name="Copyright" content="Images, text, datasets, and content (c) Copyright John S. Urban, 2002. All rights reserved.">
<meta name="generator" content="vi(1)/vim(1)" />
EOF
####################################################################################################################################
cat <<EOF
<meta name="description" content="@(#)$TOPIC::BOOK_$TOPIC: BOOK composed of pages for man(1) topic $TOPIC"/>
<meta name="author"      content="$(logname)" />
<meta name="date"        content="$(date +%Y-%m-%d)" />
<meta name="keywords"    content="Fortran, Fortran code, source code repository, Fortran library, Fortran archive, source code" />
EOF
####################################################################################################################################
cat <<\EOF
<!--
   Pick your favorite style sheet from among the eight offerings:
   Chocolate, Midnight, Modernist, Oldstyle, Steely, Swiss, Traditional, and Ultramarine.
   #!/bin/sh
   for NAME in Chocolate Midnight Modernist Oldstyle Steely Swiss Traditional Ultramarine
   do
     curl --get http://www.w3.org/StyleSheets/Core/$NAME.css >StyleSheets/$NAME.css
   done
-->
<link  rel="stylesheet"            href="StyleSheets/man.css"          type="text/css"  title="man"          />
<link  rel="alternate stylesheet"  href="StyleSheets/Simple.css"       type="text/css"  title="Simple"       />
<link  rel="alternate stylesheet"  href="StyleSheets/fancy.css"        type="text/css"  title="Local"        />
<link  rel="alternate stylesheet"  href="StyleSheets/Chocolate.css"    type="text/css"  title="Chocolate"    />
<link  rel="alternate stylesheet"  href="StyleSheets/Midnight.css"     type="text/css"  title="Midnight"     />
<link  rel="alternate stylesheet"  href="StyleSheets/Modernist.css"    type="text/css"  title="Modernist"    />
<link  rel="alternate stylesheet"  href="StyleSheets/OldStyle.css"     type="text/css"  title="OldStyle"     />
<link  rel="alternate stylesheet"  href="StyleSheets/Steely.css"       type="text/css"  title="Steely"       />
<link  rel="alternate stylesheet"  href="StyleSheets/Swiss.css"        type="text/css"  title="Swiss"        />
<link  rel="alternate stylesheet"  href="StyleSheets/Traditional.css"  type="text/css"  title="Traditional"  />
<link  rel="alternate stylesheet"  href="StyleSheets/Ultramarine.css"  type="text/css"  title="Ultramarine"  />
<link  rel="alternate stylesheet"  href="StyleSheets/fortran.css"      type="text/css"  title="fortran"      />

<script language="JavaScript1.1"  type="text/javascript">
// *** TO BE CUSTOMISED ***

var style_cookie_name = "style" ;
var style_cookie_duration = 30 ;

// *** END OF CUSTOMISABLE SECTION ***

function switch_style ( css_title )
{
// You may use this script on your site free of charge provided
// you do not remote this notice or the URL below. Script from
// http://www.thesitewizard.com/javascripts/change-style-sheets.shtml
  var i, link_tag ;
  for (i = 0, link_tag = document.getElementsByTagName("link") ;
    i < link_tag.length ; i++ ) {
    if ((link_tag[i].rel.indexOf( "stylesheet" ) != -1) &&
      link_tag[i].title) {
      link_tag[i].disabled = true ;
      if (link_tag[i].title == css_title) {
        link_tag[i].disabled = false ;
      }
    }
    set_cookie( style_cookie_name, css_title,
      style_cookie_duration );
  }
}
function set_style_from_cookie()
{
  var css_title = get_cookie( style_cookie_name );
  if (css_title.length) {
    switch_style( css_title );
  }
}
function set_cookie ( cookie_name, cookie_value,
    lifespan_in_days, valid_domain )
{
    // http://www.thesitewizard.com/javascripts/cookies.shtml
    var domain_string = valid_domain ?
                       ("; domain=" + valid_domain) : '' ;
    document.cookie = cookie_name +
                       "=" + encodeURIComponent( cookie_value ) +
                       "; max-age=" + 60 * 60 *
                       24 * lifespan_in_days +
                       "; path=/" + domain_string ;
}
function get_cookie ( cookie_name )
{
    // http://www.thesitewizard.com/javascripts/cookies.shtml
    var cookie_string = document.cookie ;
    if (cookie_string.length != 0) {
        var cookie_value = cookie_string.match (
                        '(^|;)[\s]*' +
                        cookie_name +
                        '=([^;]*)' );
        return decodeURIComponent ( cookie_value[2] ) ;
    }
    return '' ;
}
</script>

<!--
-->

EOF

cat <<EOF
<script language="JavaScript" type="text/javascript" src="$TOPIC.js"> </script>
EOF

cat <<\EOF
<script language="JavaScript1.1"  type="text/javascript">
//<![CDATA[
/* ============================================================================================================================== */
/*
   The following code merges a number of files like an include; so you
   can have a single printable document created from many small files.
   File references are NOT relative so a lot of things do not work as one
   would hope.  IFRAME and JavaScript support are required.
*/
/* ============================================================================================================================== */
FRAMECOUNT=0;
FIRSTPASS=0;
COLUMNS=0;
/* ============================================================================================================================== */
function baseName(str)
{
   var base = new String(str).substring(str.lastIndexOf('/') + 1);
    if(base.lastIndexOf(".") != -1)
        base = base.substring(0, base.lastIndexOf("."));
   return base;
}
/* ============================================================================================================================== */
function append(target){
   if(FIRSTPASS == 0){
      append_index(target);
   }else{
      append_doc(target);
   }
}
/* ============================================================================================================================== */
//alert('START 1');
function append_index(target){
   FRAMECOUNT=FRAMECOUNT+1;
   if( COLUMNS == 5 ){
	   document.write('</tr>\n');
	   COLUMNS=0;
   }
   COLUMNS=COLUMNS+1;
   if( COLUMNS == 1 ){
	   document.write('<tr>\n');
   }
   document.write('<td><a href="#DOCUMENT'+ FRAMECOUNT  + '">' + baseName(target) + '</a></td>\n');
}
/* ============================================================================================================================== */
//alert('START');
function append_doc(target){
   FRAMECOUNT=FRAMECOUNT+1;
   /* document.write('<xmp>');
   */
   document.write('<br class="newpage"/>');
   /*
   document.write('<a name="DOCUMENT'+ FRAMECOUNT  + '"><a href="#TOP"> &nbsp;INDEX</a></a>\n');
   document.write('<button type="button" onclick="javascript:history.back()">Index</button>\n');
   */

   document.write('<div id="display' + FRAMECOUNT + '"></div>');
   document.write('<iframe width="0" height="0" id="buffer' + FRAMECOUNT + '" name="buffer' + FRAMECOUNT + '" src="' + target + '" ');
   document.write('onload="copyIframe(');
   document.write('\'buffer' + FRAMECOUNT + '\',');
   document.write('\'display' + FRAMECOUNT + '\'');
   document.write(')"></iframe>\n');
   /* document.write('</xmp>');
   */
}
/* ============================================================================================================================== */
/*
   on load of iframe displays body content of IFRAME document in DIV
*/

function copyIframe(iframeId, divId ) {
    var CurrentDiv = document.getElementById? document.getElementById(divId): null;
    if ( window.frames[iframeId] && CurrentDiv ) {
       /* copy data in iframe to div */
        CurrentDiv.innerHTML = window.frames[iframeId].document.body.innerHTML;
        CurrentDiv.style.display = 'block';
    }
}
/* ============================================================================================================================== */
//alert('GOT HERE 2 END');
/* ============================================================================================================================== */
//]]>
</script>
<title></title>
</head>
<body onload="set_style_from_cookie()">
<a name="TOP">&nbsp;</a>

<div>
<form>
Themes:
<input  type="submit"  onclick="switch_style('man');return          false;"  name="theme"  value="man"          id="man">
<input  type="submit"  onclick="switch_style('Simple');return       false;"  name="theme"  value="Simple"       id="Simple">
<input  type="submit"  onclick="switch_style('fortran');return      false;"  name="theme"  value="fortran"      id="fortran">
<input  type="submit"  onclick="switch_style('Local');return        false;"  name="theme"  value="Local"        id="Local">
<input  type="submit"  onclick="switch_style('Chocolate');return    false;"  name="theme"  value="Chocolate"    id="Chocolate">
<input  type="submit"  onclick="switch_style('Midnight');return     false;"  name="theme"  value="Midnight"     id="Midnight">
<input  type="submit"  onclick="switch_style('Modernist');return    false;"  name="theme"  value="Modernist"    id="Modernist">
<input  type="submit"  onclick="switch_style('Oldstyle');return     false;"  name="theme"  value="Oldstyle"     id="Oldstyle">
<input  type="submit"  onclick="switch_style('Steely');return       false;"  name="theme"  value="Steely"       id="Steely">
<input  type="submit"  onclick="switch_style('Traditional');return  false;"  name="theme"  value="Traditional"  id="Traditional">
<input  type="submit"  onclick="switch_style('Ultramarine');return  false;"  name="theme"  value="Ultramarine"  id="Ultramarine">
</form>
</div>
<hr>
<h3>SHORTCUTS:</h3>
<script language="JavaScript1.1"  type="text/javascript">
document.write('<center><table border="4" >\n');
document.write('<tbody>\n');
loadthem();
if (COLUMNS != 5 ){
   document.write('</tr>\n');
}
document.write('</tbody>\n');
document.write('</table></center>\n');
document.write('<hr\n>');
FIRSTPASS=1;
FRAMECOUNT=0;
loadthem();
</script>
</div>
</body>
EOF
}
####################################################################################################################################
BOOKNAME=$1
SECTION=$2
   echo 'Creating book '"$BOOKNAME"
   INDX $BOOKNAME $SECTION
####################################################################################################################################
exit
####################################################################################################################################
137c217
<    document.write('<td><a href="#DOCUMENT'+ FRAMECOUNT  + '">' + baseName(baseName(target)) + '</a></td>\n');
---
>    document.write('<td><a href="#DOCUMENT'+ FRAMECOUNT  + '">' + baseName(target) + '</a></td>\n');

146,147c226
<    #document.write('<a name="DOCUMENT'+ FRAMECOUNT  + '"><a href="#TOP"> &nbsp;INDEX</a></a>\n');
<    document.write('<button type="button" onclick="javascript:history.back()">Index</button>\n');
---
>    document.write('<a name="DOCUMENT'+ FRAMECOUNT  + '"><a href="#TOP"> &nbsp;INDEX</a></a>\n');
############
2a3
> export MANPATH=$(dirname $0)/../../man
8,9c9,10
< export TOPHTML=${TOPHTML:-tmp/html}
< export MAN_CMD=${MAN_CMD:-mank}
---
> export TOPHTML=${TOPHTML:-../docs}
> export MAN_CMD=${MAN_CMD:-man}
278a200
>    /*
279a202,203
>    document.write('<button type="button" onclick="javascript:history.back()">Index</button>\n');
>    */
353d276
<    banner.sh $BOOKNAME
357a281,290
> 137c217
> <    document.write('<td><a href="#DOCUMENT'+ FRAMECOUNT  + '">' + baseName(baseName(target)) + '</a></td>\n');
> ---
> >    document.write('<td><a href="#DOCUMENT'+ FRAMECOUNT  + '">' + baseName(target) + '</a></td>\n');
> 
> 146,147c226
> <    #document.write('<a name="DOCUMENT'+ FRAMECOUNT  + '"><a href="#TOP"> &nbsp;INDEX</a></a>\n');
> <    document.write('<button type="button" onclick="javascript:history.back()">Index</button>\n');
> ---
> >    document.write('<a name="DOCUMENT'+ FRAMECOUNT  + '"><a href="#TOP"> &nbsp;INDEX</a></a>\n');
