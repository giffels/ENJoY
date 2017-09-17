CERTIFICATEDIR=/etc/pki/nginx
CERTIFICATE=$CERTIFICATEDIR/server.crt
KEY=$CERTIFICATEDIR/server.key

function create_host_cert() {
  mkdir -p $CERTIFICATEDIR
  openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $KEY -out $CERTIFICATE -subj "/C=DE/ST=BW/L=Karlsruhe/O=SCC/CN=$(hostname -f)"
  return $?
}

function check_host_cert(){
  if [ -f $CERTIFICATES ]; then
    if ! openssl x509 -checkend 2592000 -noout -in $CERTIFICATE; then
      rm $CERTIFCATE
      create_host_cert
      return $?
    fi
  else
    create_host_cert
    return $?
  fi
  return 0
}

check_host_cert