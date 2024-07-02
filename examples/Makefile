
VCON_PATH=../../../
GENERATED_EXAMPLES=ab_call_ext_rec.vcon \
         ab_call_int_rec.vcon \
         ab_call_ext_rec_signed.vcon \
         ab_call_ext_rec_encrypted.vcon \
         ab_call_ext_rec_decrypted.vcon \
         ab_call_ext_rec_decrypted_verified.vcon \
         ab_email_acct_prob_thread.vcon \
         ab_email_prob_followup_text_thread.vcon
GENERATED_DEPENDENCIES= ab_email_prob_followup_alice.vcon \
         ab_email_prob_followup_bob_reply.vcon \
         b_email_acct_prob_image.vcon
EXAMPLES=simple-vcon.vcon ${GENERATED_EXAMPLES}
INCLUDES=$(EXAMPLES:.vcon=.pp)
#VCON_PYPATH="${VCON_PATH}vcon/vcon:${VCON_PATH}vcon/vcon/bin"
VCON_PYPATH="${VCON_PATH}py-vcon"
VCON=${VCON_PATH}py-vcon/vcon/bin/vcon
CERTPATH=${VCON_PATH}py-vcon/certs/

all: ${VCON_PATH}vcon ${INCLUDES}

${VCON_PATH}/py-vcon:
	(cd ${VCON_PATH} ; git clone https://github.com/vcon-dev/vcon.git)

vcon_includes: $(INCLUDES)
	echo "Making $(INCLUDES)"
	echo "from: $(EXAMPLES)"

clean:
	rm -f ${INCLUDES} ${GENERATED_EXAMPLES} ${GENERATED_DEPENDENCIES}

%.pp: %.vcon
	echo "building $@ from $^"
	cat $^ | ./trunc_lines.sh > $@

ab_call_ext_rec.vcon: ${VCON_PATH}vcon ${VCON} ab.vcon ab_call.wav 
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab.vcon add ex-recording ab_call.wav 2022-06-21T13:53:26-04:00 "[0,1]" https://raw.githubusercontent.com/dgpetrie/draft-petrie-vcon/main/examples/ab_call.wav  | jq '.' > ab_call_ext_rec.vcon)

ab_call_ext_rec_signed.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec.vcon sign ${CERTPATH}fake_grp.key ${CERTPATH}fake_grp.crt ${CERTPATH}fake_div.crt ${CERTPATH}fake_ca_root.crt | jq '.' > ab_call_ext_rec_signed.vcon)

ab_call_ext_rec_encrypted.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec_signed.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec_signed.vcon encrypt ${CERTPATH}fake_grp.crt | jq '.' > ab_call_ext_rec_encrypted.vcon)

ab_call_ext_rec_decrypted.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec_encrypted.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec_encrypted.vcon decrypt ${CERTPATH}fake_grp.key ${CERTPATH}fake_grp.crt | jq '.' > ab_call_ext_rec_decrypted.vcon)

ab_call_ext_rec_decrypted_verified.vcon: ${VCON_PATH}vcon ${VCON} ab_call_ext_rec_decrypted.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_ext_rec_decrypted.vcon verify ${CERTPATH}fake_ca_root.crt | jq '.' > ab_call_ext_rec_decrypted_verified.vcon)

ab_call_int_rec.vcon: ${VCON_PATH}vcon ${VCON} ab.vcon ab_call.wav 
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab.vcon add in-recording ab_call.wav 2022-06-21T13:53:26-04:00 "[0,1]" | jq '.' > ab_call_int_rec.vcon)

b_email_acct_prob_image.vcon: email_acct_prob_bob_image.txt
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -n add in-email email_acct_prob_bob_image.txt | jq '.' > b_email_acct_prob_image.vcon)

ab_email_acct_prob_thread.vcon: b_email_acct_prob_image.vcon email_acct_prob_alice_reply.txt
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i b_email_acct_prob_image.vcon add in-email email_acct_prob_alice_reply.txt | jq '.' > ab_email_acct_prob_thread.vcon)

ab_email_prob_followup_alice.vcon: email_prob_followup_alice.txt
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -n add in-email email_prob_followup_alice.txt | jq '.' > ab_email_prob_followup_alice.vcon)

ab_email_prob_followup_bob_reply.vcon: ab_email_prob_followup_alice.vcon email_prob_followup_bob_reply.txt
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_email_prob_followup_alice.vcon add in-email email_prob_followup_bob_reply.txt | jq '.' > ab_email_prob_followup_bob_reply.vcon)

ab_email_prob_followup_text_thread.vcon: ab_email_prob_followup_bob_reply.vcon email_prob_followup_alice_ack.txt
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_email_prob_followup_bob_reply.vcon add in-email email_prob_followup_alice_ack.txt | jq '.' > ab_email_prob_followup_text_thread.vcon)

ab_call_int_rec_analysis.vcon: ab_call_int_rec.vcon
	(export PYTHONPATH=${VCON_PYPATH}:${PATHONPATH} ; ${VCON} -i ab_call_int_rec.vcon filter deepgram | jq '.' > ab_call_int_rec_analysis.vcon)
