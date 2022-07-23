
VCON_PATH=../../../
EXAMPLES=simple-vcon.vcon ab_call_ext_rec.vcon ab_call_int_rec.vcon ab_call_ext_rec_signed.vcon ab_call_ext_rec_encrypted.vcon
INCLUDES=$(EXAMPLES:.vcon=.pp)
#VCON_PYPATH="${VCON_PATH}vcon/vcon:${VCON_PATH}vcon/vcon/bin"
VCON_PYPATH="${VCON_PATH}vcon"
VCON=${VCON_PATH}vcon/vcon/bin/vcon
CERTPATH=${VCON_PATH}vcon/certs/

all: ${VCON_PATH}vcon ${INCLUDES}

${VCON_PATH}/vcon:
	(cd ${VCON_PATH} ; git clone https://github.com/vcon-dev/vcon.git)

vcon_includes: $(INCLUDES)
	echo "Making $(INCLUDES)"
	echo "from: $(EXAMPLES)"

%.pp: %.vcon
	echo "building $@ from $^"
	cat $^ | ./trunc_lines.sh > $@

ab_call_ext_rec.vcon: ${VCON_PATH}vcon ${VCON} ab.vcon ab_call.wav 
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab.vcon add ex-recording ab_call.wav 2022-06-21T13:53:26-04:00 "[0,1]" https://raw.githubusercontent.com/dgpetrie/draft-petrie-vcon/main/examples/ab_call.wav  | jq '.' > ab_call_ext_rec.vcon)

ab_call_ext_rec_signed.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec.vcon sign ${CERTPATH}fake_grp.key ${CERTPATH}fake_grp.crt ${CERTPATH}fake_div.crt ${CERTPATH}fake_ca_root.crt | jq '.' > ab_call_ext_rec_signed.vcon)

ab_call_ext_rec_encrypted.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec_signed.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec_signed.vcon encrypt ${CERTPATH}fake_grp.crt | jq '.' > ab_call_ext_rec_encrypted.vcon)

ab_call_int_rec.vcon: ${VCON_PATH}vcon ${VCON} ab.vcon ab_call.wav 
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab.vcon add in-recording ab_call.wav 2022-06-21T13:53:26-04:00 "[0,1]" | jq '.' > ab_call_int_rec.vcon)
