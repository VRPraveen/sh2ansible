#!/bin/bash
os=$(uname)
echo -e $os
RHAT_RELEASE="/etc/redhat-release"
{
   os_version=""
   if [[ "$os" = "Linux" ]]; then
      KERNEL_VERSION=$(uname -r)

       # RHEL...
      if [[ -f "$RHAT_RELEASE" ]]; then
         os_version=$(cat $RHAT_RELEASE 2>/dev/null | awk '{printf("%s ", $0)};END{printf("\n")}' | sed 's/Red Hat Enterprise Linux Server release/RHEL/g' | cut -f1 -d'(' | sed 's/ \+$//g')
         RHEL_VERSION=$(echo $os_version | awk '{print $2}' | cut -f1 -d'.')
         RHEL_MINOR=$(echo $os_version | awk '{print $2}' | cut -f2 -d'.')
         RHEL_ARCH=$(uname -i)
         os_version="$os_version ($RHEL_ARCH)"
      fi

      # Other...
      if [[ "$os_version" = "" ]]; then
         os_version=$(uname -a)
      fi
   fi
   if [[ "$os" = "SunOS" ]]; then
      os_version=$(uname -r)
   fi

   os_version=$(echo $os_version | sed 's/,/ /g')

}
