curl -i -H "Content-Type applicationjson" -X POST --data 'user[username]=rupert&user[email]=rupert@2rmobile.com&user[password]=junjunmalupet&user[password_confirmation]=junjunmalupet' http://127.0.0.1:3000/api/users.json
curl -i -H "Content-Type applicationjson" -X POST --data 'username=rupert&password=junjunmalupet' http://127.0.0.1:3000/api/users/sign_in.json
