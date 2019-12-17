. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

sh /vagrant_scripts/install_os_packages.sh

echo "******************************************************************************"
echo "Set root and oracle password and change ownership of /u01." `date`
echo "******************************************************************************"
echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | passwd
echo -e "${ORACLE_PASSWORD}\n${ORACLE_PASSWORD}" | passwd oracle
chown -R oracle:oinstall /u01
chmod -R 775 /u01

sh /vagrant_scripts/configure_hosts_base.sh

sh /vagrant_scripts/configure_chrony.sh

su - oracle -c 'sh /vagrant/scripts/oracle_user_environment_setup.sh'
. /home/oracle/scripts/setEnv.sh

sh /vagrant_scripts/configure_hostname.sh

su - oracle -c 'sh /vagrant_scripts/oracle_db_software_installation.sh'

echo "******************************************************************************"
echo "Run DB root scripts." `date` 
echo "******************************************************************************"
sh ${ORA_INVENTORY}/orainstRoot.sh
sh ${ORACLE_HOME}/root.sh

su - oracle -c 'sh /vagrant/scripts/oracle_create_database.sh'

#echo "******************************************************************************"
#echo "Run TDE configuration scripts." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_configure_tde.sh'

#echo "******************************************************************************"
#echo "Run Database Vault configuration scripts." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_configure_dv.sh'

#echo "******************************************************************************"
#echo "Run OPatch update script." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_opatch_update.sh'

#echo "******************************************************************************"
#echo "Run shutdown script." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_shutdown.sh'

#echo "******************************************************************************"
#echo "Run patch script." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_patch_db.sh'

#echo "******************************************************************************"
#echo "Run startup script." `date`
#echo "******************************************************************************"
#su - oracle -c 'sh /vagrant/scripts/oracle_startup.sh'



