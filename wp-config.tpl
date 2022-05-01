<?php

define( 'DB_NAME', "{{ db_database.db_name }}" );
define( 'DB_USER', "{{ db_database.db_user }}" );
define( 'DB_PASSWORD', "{{ db_database.db_passwd }}" );
define( 'DB_HOST',  "${db_host}" );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         'de!}AWi<C>wNEjV4X7ZT qkgE:|wgvgDK4i]s9`]pQrGTV@D8.`Ngyz4#W;bd>)^' );
define( 'SECURE_AUTH_KEY',  '&b+<tDsF>beB6-?Q$Fb2j)4vlZYJ/o,^Q9b]P#5BEk]R/Z%:bh=%#Ky}Y+@x[]vv' );
define( 'LOGGED_IN_KEY',    '%K)#H#+)</-G9*6-:O4%SjI|pwgKi5yA4|xoFI< s.Y;Lq:rv::]Ii`|Z9rzw,mo' );
define( 'NONCE_KEY',        'kA90iI lF>q`iN{;7h=L]}R6X+495Y^G# .~/OX{WjWM*3VsMfD/Agx?Vx?Xw.U_' );
define( 'AUTH_SALT',        '5Ba73e$%(]F_%ze-D W10[2u9[TJse?Rq=ZDfAd&O$-R5@HT(-e%-o5Hv5ZZgMbN' );
define( 'SECURE_AUTH_SALT', 'cd(P@E+qnwq)_n7DiogAqIZ=_BBz~q%N|p$&{N#B0Wj!&&:`d&;t(4oBIDbParXL' );
define( 'LOGGED_IN_SALT',   'ar4U >)Vvr|2yEo((P[MzF(l.eznOx!k:KkO:SNL`{A_VKE:f1t|Gt{v88gB4x(H' );
define( 'NONCE_SALT',       '!e)+NmDMw;<[DsARlcmr-s(c.*&<Y^ftPO$_j<Jsi>QWP@w#Dg3 vcKk{Sc %ocz' );

$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
