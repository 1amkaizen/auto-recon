todate=$(date +"%Y-%m-%d")
COFF='\033[0m' # Text Reset
# Bold
BBlack='\033[1;30m'  # Black
BRed='\033[1;31m'    # Red
BGreen='\033[1;32m'  # Green
BYellow='\033[1;33m' # Yellow
BBlue='\033[1;34m'   # Blue
BPurple='\033[1;35m' # Purple
BCyan='\033[1;36m'   # Cyan
BWhite='\033[1;37m'  # White
Red='\033[0;31m'          # Red
Green='\033[0;32m'
reset=$(tput sgr0)

domain=
subreport=
usage() { echo -e "${BYellow}Usage: kaizen -d domain.com " 1>&2; exit 1; }

while getopts ":d:e:r:" o; do
    case "${o}" in
        d)
            domain=${OPTARG}
            ;;

        *)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

if [ -z "${domain}" ] && [[ -z ${subreport[@]} ]]; then
   usage; exit 1;
fi

heads(){
echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="viewport" content="width=device-width, initial-scale=1.0" />' >> ~/report/$domain/report.html
echo "<title>Recon Report for $domain</title>" >> ~/report/$domain/report.html
echo '<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" /><link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css" />    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />   <link rel="stylesheet" href="../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css" /> <link rel="stylesheet" href="../plugins/icheck-bootstrap/icheck-bootstrap.min.css" />   <link rel="stylesheet" href="../plugins/jqvmap/jqvmap.min.css" /><link rel="stylesheet" href="../css/adminlte.min.css" />   <link rel="stylesheet" href="../plugins/overlayScrollbars/css/OverlayScrollbars.min.css" /><link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker.css" /><link rel="stylesheet" href="../plugins/summernote/summernote-bs4.min.css" /><link rel="stylesheet" href="../css/bootstrap.min.css" /><link rel="stylesheet" href="../css/dataTables.bootstrap5.min.css" /><link rel="stylesheet" href="../css/datatables.css" /><link rel="stylesheet" href="../css/datatables.min.css" /><link rel="stylesheet" href="../css/responsive.bootstrap4.min.css" /><link rel="stylesheet" href="../css/buttons.bootstrap4.min.css" /><link rel="stylesheet" href="../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css"><link rel="stylesheet" href="../plugins/datatables-responsive/css/responsive.bootstrap4.min.css"><link rel="stylesheet" href="../plugins/datatables-buttons/css/buttons.bootstrap4.min.css"></head>' >> ~/report/$domain/report.html
echo '<script src="../plugins/jquery/jquery.min.js"></script><script src="../plugins/jquery-ui/jquery-ui.min.js"></script><script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>  <script src="../plugins/chart.js/Chart.min.js"></script>   <script src="../plugins/sparklines/sparkline.js"></script>  <script src="../plugins/jqvmap/jquery.vmap.min.js"></script><script src="../plugins/jqvmap/maps/jquery.vmap.usa.js"></script>  <script src="../plugins/jquery-knob/jquery.knob.min.js"></script><script src="../plugins/moment/moment.min.js"></script><script src="../plugins/daterangepicker/daterangepicker.js"></script>  <script src="../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>   <script src="../plugins/summernote/summernote-bs4.min.js"></script>  <script src="../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>  <script src="../js/adminlte.js"></script></script><script src="../js/pages/dashboard.js"></script><script src="../plugins/datatables/jquery.dataTables.min.js"></script><script src="../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script><script src="../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script><script src="../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script><script src="../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script><script src="../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script><script src="../plugins/jszip/jszip.min.js"></script><script src="../plugins/pdfmake/pdfmake.min.js"></script><script src="../plugins/pdfmake/vfs_fonts.js"></script><script src="../plugins/datatables-buttons/js/buttons.html5.min.js"></script><script src="../plugins/datatables-buttons/js/buttons.print.min.js"></script><script src="../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>' >> ~/report/$domain/report.html
echo '<style>a {text-decoration:none;}</style>' >> ~/report/$domain/report.html
echo '<script>
      $.widget.bridge("uibutton",
	  $.ui.button);
    </script>' >> ~/report/$domain/report.html
echo '<script>$(function () {
    $("#table1")
        .DataTable({
          buttons: ["copy", "csv", "pdf" , "colvis"],
          paging: true,
          ordering: true,
          info: true,
          responsive: true,
          lengthChange: false,
          autoWidth: false,
    })
        .buttons()
        .container()
        .appendTo("#table1_wrapper .col-md-6:eq(0)");
    $("#table2")
     .DataTable({
      buttons: ["copy", "csv", "pdf" , "colvis"],
      paging: true,
      lengthChange: false,
      searching: true,
      ordering: true,
      info: true,
      autoWidth: false,
      responsive: true,
    })
      .buttons()
     .container()
     .appendTo("#table2_wrapper .col-md-6:eq(0)");
  });
</script></head>' >> ~/report/$domain/report.html


}
navbar(){
echo '<nav class="main-header navbar navbar-expand navbar-dark"><div class="card-header p-0"><ul class="navbar-nav nav" id="custom-tabs-one-tab" role="tablist"><li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="file:///home/kali/report/$domain/report.html" role="button"><i class="fas fa-bars"></i></a></li></ul></div><ul class="navbar-nav nav ml-auto" id="custom-tabs-one-tab" role="tablist"><li class="nav-item"><a class="nav-link" data-widget="navbar-search" href="#" role="button"><i class="fas fa-search"></i></a><div class="navbar-search-block"><form class="form-inline"><div class="input-group input-group-sm"><input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search" /><div class="input-group-append"><button class="btn btn-navbar" type="submit"><i class="fas fa-search"></i></button><button class="btn btn-navbar" type="button" data-widget="navbar-search"><i class="fas fa-times"></i></button></div></div></form></div></li><li class="nav-item"><a class="nav-link" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="false"><i class="fas fa-home"></i></a></li><li class="nav-item"><a class="nav-link" id="custom-tabs-one-directory-tab" data-toggle="pill" href="#custom-tabs-one-directory" role="tab" aria-controls="custom-tabs-one-directory" aria-selected="false"><i class="fas fa-book"></i></a></li><li class="nav-item"><a class="nav-link" id="custom-tabs-one-profile-tab" data-toggle="pill" href="#custom-tabs-one-profile" role="tab" aria-controls="custom-tabs-one-profile" aria-selected="false"><i class="fas fa-user"></i></a></li></ul></nav>' >> ~/report/$domain/report.html
}
sidebar(){
echo "<aside class='main-sidebar sidebar-dark-primary elevation-4'><a href='file:///home/kali/report/$domain/report.html' class='brand-link'><img src='../img/logo.png' alt='AdminLTE Logo' class='brand-image img-circle elevation-3' style='opacity: 0.8' /><span class='brand-text font-weight-light'>Report</span></a><div class='sidebar'><div class='user-panel mt-3 pb-3 mb-3 d-flex'><div class='image'><img src='../img/1amkaizen.png' class='img-circle elevation-2' alt='User Image' /></div><div class='info'><a href='#profile' class='d-block'> 1amkaiz3n</a></div></div><div class='form-inline'><div class='input-group' data-widget='sidebar-search'><input class='form-control form-control-sidebar' type='search' placeholder='Search' aria-label='Search' /><div class='input-group-append'><button class='btn btn-sidebar'><i class='fas fa-search fa-fw'></i></button></div></div></div><nav class='mt-2'><ul class='nav nav-pills nav-sidebar flex-column' data-widget='treeview' role='menu' data-accordion='false'><li class='nav-item'><a href='#' class='nav-link'><i class='nav-icon fas fa-tachometer-alt'></i><p>Dashboard<i class='right fas fa-angle-left'></i></p></a><ul class='nav nav-treeview'><li class='nav-item'><a href='index.html' class='nav-link'><i class='far fa-circle nav-icon'></i><p>Dashboard v1</p></a></li><li class='nav-item'><a href='index2.html' class='nav-link'><i class='far fa-circle nav-icon'></i><p>Dashboard v2</p></a></li><li class='nav-item'><a href='#' class='nav-link'><i class='far fa-circle nav-icon'></i><p>Dashboard v3</p></a></li></ul></li></ul></nav></div></aside>" >> ~/report/$domain/report.html

}
breadcumb(){
echo '<section class="content-header"><div class="container-fluid"><div class="row mb-2"><div class="col-sm-6">' >> ~/report/$domain/report.html
echo "<h1 class='post-title  text-uppercase fw-bold' itemprop='name headline'>Recon Report for <a class='text-primary fw-bold' href=\'http://$domain\'>$domain</a></h1>" >> ~/report/$domain/report.html
echo "</div><div class='col-sm-6'><p class='float-sm-right'>Generated By 1amkaiz3n on $todate</p></div></div></div></section>" >> ~/report/$domain/report.html
}
tab-home(){
echo '<div class="tab-pane fade show active" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab"><div class="container-fluid">' >> ~/report/$domain/report.html
table(){
echo '<div class="row"><div class="col-12"><div class="card"><div class="card-header bg-primary text-center text-uppercase"><h3>Scanned Subdomains</h3></div><div class="card-body">' >> ~/report/$domain/report.html
echo '<table id="table1" class="table table-bordered table-striped"><thead><tr><th>Subdomains</th><th>Server</th><th>Arecords</th><th>Addres</th><th>Status Code</th><th>Status</th></tr></thead> <tbody>' >> ~/report/$domain/report.html
cat ~/report/$domain/hosts | while read nline ; do
status=$(curl -o /dev/null --silent --head --write-out "%{http_code} $nline\n" "$nline" | awk '{print $1}')
server=$(curl -sI --silent $nline | tr -d '\r' | sed -En 's/^Server: (.*)/\1/p')
arec=$(echo $nline | dnsx -silent -a -resp-only)
addr=$(echo $nline | sed 's/\http\:\/\///g' |  sed 's/\https\:\/\///g' | sudo fping -A   | awk '{print $1}')
stat=$(echo $nline | sed 's/\http\:\/\///g' |  sed 's/\https\:\/\///g' | sudo fping -A   | awk '{print $2,$3}')
echo "<tr class='text-white'><td><a class='text-danger'  href='$nline'>$nline</a></td><td class='text-white'>$server</td><td class='text-white'>$arec</td><td class='text-white'>$addr</td><td class='text-white'>$status</td><td class='text-white'>$stat</td></tr>" >> ~/report/$domain/report.html ;done
echo '</tbody></table>' >> ~/report/$domain/report.html
echo '</div></div></div></div>' >> ~/report/$domain/report.html
}
profile(){
echo '<div class="row">' >> ~/report/$domain/report.html
echo '<div class="col-md-3"><div class="card card-primary card-outline"><div class="card-body box-profile">' >> ~/report/$domain/report.html
title=$(whatweb $domain  -q -v --color=never | grep Title)
echo "<div class='text-center'><img class='profile-user-img img-fluid img-circle' src='../img/1amkaizen.png' alt='User profile picture' /></div><h3 class='profile-username text-center'>$domain</h3><p class='text-warning text-center'>$title</p><ul class='list-group list-group-unbordered mb-3'><li class='list-group-item text-white'> " >> ~/report/$domain/report.html
sub=$(wc -l ~/report/$domain/domains | awk '{print $1}')
alive=$(wc -l ~/report/$domain/hosts | awk '{print $1}')
vuln=$(wc -l ~/report/$domain/pos.txt | awk '{print $1}')
echo "<b>Subdomains</b><a class='float-right'>$sub</a></li><li class='list-group-item text-white'><b>Host Alive</b> <a class='float-right'>$alive</a></li><li class='list-group-item text-white'><b>Vuln</b><a class='float-right'>$vuln</a></li></ul><a href='#' class='btn btn-primary btn-block'><b>Follow</b></a></div></div> " >> ~/report/$domain/report.html
header=$(curl --silent --head $domain)
ip=$(sudo fping $domain -A | awk '{print $1}')
loc=$(curl ipinfo.io/$ip?token=53a22f55fbb35c)
echo "<div class='card card-primary'><div class='card-header'><h5 class='text-center'>About $domain</h5></div><div class='card-body'><strong><i class='fas fa-book mr-1'></i>Headers</strong><pre class='text-warning'>$header</pre><hr /><strong><i class='fas fa-map-marker-alt mr-1'></i> Location</strong><pre class='text-warning'>$loc</pre><hr /><strong><i class='fas fa-pencil-alt mr-1'></i> Skills</strong><p class='text-muted'><span class='tag tag-danger'>UI Design</span><span class='tag tag-success'>Coding</span><span class='tag tag-info'>Javascript</span><span class='tag tag-warning'>PHP</span><span class='tag tag-primary'>Node.js</span></p><hr /><strong><i class='far fa-file-alt mr-1'></i> Notes</strong><p class='text-muted'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fermentum enim neque.</p></div></div></div>" >> ~/report/$domain/report.html
#
echo '<div class="col-md-9">' >> ~/report/$domain/report.html
echo '<div class="card">' >> ~/report/$domain/report.html
echo '<div class="card-header p-2"><ul class="nav nav-pills"><li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">Dig</a></li><li class="nav-item"><a class="nav-link" href="#timeline" data-toggle="tab">Nslookup</a></li><li class="nav-item"><a class="nav-link" href="#chat" data-toggle="tab">Whois</a></li><li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab">Host</a></li><li class="nav-item"><a class="nav-link" href="#whatweb" data-toggle="tab">Whatweb</a></li><li class="nav-item"><a class="nav-link" href="#nmap" data-toggle="tab">Nmap</a></li></ul></div>' >> ~/report/$domain/report.html
echo '<div class="card-body">' >> ~/report/$domain/report.html
tab-content(){
echo '<div class="tab-content">' >> ~/report/$domain/report.html
echo "<div class='active tab-pane' id='activity'>" >> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(dig $domain)
</pre>
" >> ~/report/$domain/report.html
echo "</div><div class='timeline tab-pane' id='timeline'>" >> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(nslookup $domain)
</pre>
" >> ~/report/$domain/report.html
echo "</div><div class='chat tab-pane' id='chat'>" >> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(whois $domain | egrep -i 'Registr|Sponsoring Registrar|Registrant|Domain Name|Admin|Tech|Name Server|Billing|ID|DNSSEC|!internic')
</pre>
" >> ~/report/$domain/report.html
echo "</div><div class='settings tab-pane' id='settings'> ">> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(host $domain)
</pre>
" >> ~/report/$domain/report.html
echo "</div><div class='whatweb tab-pane' id='whatweb'> ">> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(whatweb $domain --color=never -v -q)
</pre>
" >> ~/report/$domain/report.html
echo "</div><div class='nmap tab-pane' id='nmap'> ">> ~/report/$domain/report.html
echo "
<pre class='text-warning'>
$(dig $domain)
</pre>
" >> ~/report/$domain/report.html
echo "</div></div>" >> ~/report/$domain/report.html
}
tab-content
# col-me-9,card,card body
echo '</div></div></div>' >> ~/report/$domain/report.html
#row
echo '</div>' >> ~/report/$domain/report.html
}
table
profile
# tab-pane & container-fluid
echo '</div></div>' >> ~/report/$domain/report.html
}
tab-directory(){
echo '<div class="tab-pane fade" id="custom-tabs-one-directory" role="tabpanel" aria-labelledby="custom-tabs-one-directory-tab">' >> ~/report/$domain/report.html
echo '<div class="container-fluid">' >> ~/report/$domain/report.html
table(){
echo "<div class='row'><div class='col-md-12'><div class='card'>" >> ~/report/$domain/report.html
echo "<div class='card-header bg-primary text-white text-center text-uppercase'><h3 class='card-title fw-bold'>Total Scanned  Directory</h3></div>" >> ~/report/$domain/report.html
echo '<div class="card-body bg-dark text-white">' >> ~/report/$domain/report.html
echo '<table id="table2" class="table table-bordered table-striped"><thead><tr><th>Urls</th><th>Directory</th><th>Size</th><th>Status</th></tr></thead> <tbody>' >> ~/report/$domain/report.html
cat ~/report/$domain/directory | while read nline ; do
url=$(echo $nline | awk '{print $7}' | sed 's/\]//g')
dir=$(echo $nline | awk '{print $1}')
size=$(echo $nline | awk '{print $5}' | sed 's/\]//g')
stat=$(echo $nline | awk '{print $3}' | sed 's/)//g')
echo "<tr class='text-white'><td><a class='text-danger'  href='$url'>$url</a></td><td class='text-white'>$dir</td><td class='text-white'>$size</td><td class='text-white'>$stat</td></tr>" >> ~/report/$domain/report.html ;done
echo '</tbody></table>' >> ~/report/$domain/report.html
echo '</div>' >> ~/report/$domain/report.html
echo '</div></div></div>' >> ~/report/$domain/report.html
}


table
echo '</div>' >> ~/report/$domain/report.html
echo '</div>' >> ~/report/$domain/report.html
}
#tab-profile(){
#echo '<div class="tab-pane fade" id="custom-tabs-one-profile" role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">tab-profile kosong</div>' >> ~/report/$domain/report.html
#}


report(){
heads
echo '<body class="hold-transition dark-mode sidebar-mini layout-fixed"><div class="wrapper">' >> ~/report/$domain/report.html
navbar
sidebar
echo '<div class="content-wrapper">' >> ~/report/$domain/report.html
breadcumb
echo '<section class="content"><div class="tab-content" id="custom-tabs-one-tabContent">' >> ~/report/$domain/report.html
tab-home
tab-directory
echo '</div></section>' >> ~/report/$domain/report.html
echo '</div>' >> ~/report/$domain/report.html
echo '</div></body>' >> ~/report/$domain/report.html
echo '</html>' >> ~/report/$domain/report.html
}
report $domain
todate=$(date +"%Y-%m-%d")
duration=$SECONDS
echo -e "${Green}Report success ==> ${BGreen}file:///home/kali/report/$domain/report.html${reset}"
echo -e "${Green}Scan completed in : ${BGreen}$(($duration / 60)) minutes and $(($duration % 60)) seconds."

