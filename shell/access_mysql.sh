#!bin/bash
#Date: 2017.10.17
#Author: chench9@lenovo.com
#Desc:
#
#		access mysql by shell
#

HOST="10.100.157.70"
USER="moc"
PWD="moc"
DB="moc"
CMD="mysql -h${HOST} -u${USER} -p${PWD} -D${DB} --default-character-set=utf8 -A -N"

#
# Query company
#
query_company() {
	sql="select * from company"
	$CMD -e "$sql" >> company.data
}


#
# Update company
#
update_company() {
	sql="update company set name='test' where id=1"
	$CMD -e "$sql"
}

#
# Delete company
#
delete_company() {
	sql="delete from company where id=1"
	$CMD -e "$sql"
}

#
# Add company
#
add_company() {
	sql="insert into company(name,parent,create_time,update_time) values('test',1,now(),now())"
	$CMD -e "$sql"
}

query_company

