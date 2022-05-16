#!/bin/bash
clear
echo -e "Bienvenid@ al instalador de SysAdminTool"
echo -e "Va a instalar la versión 1.0 de SysAdminTool"
mv ../SysAdminTool /usr/sbin 2>/dev/null
touch /usr/sbin/sysadmintool
echo "#!/bin/bash" > /usr/sbin/sysadmintool
echo "cd /usr/sbin/SysAdminTool" >> /usr/sbin/sysadmintool
echo ". /usr/sbin/SysAdminTool/menuprincipal.sh" >> /usr/sbin/sysadmintool
chmod +x /usr/sbin/sysadmintool
