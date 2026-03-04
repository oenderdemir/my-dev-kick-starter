#############################################################
#
# Bu script in kurduğu programların bazılarının mutlaka kurulması istenmektedir ve kullanıcıya sormadan kurulur,
# bazı programlar ise opsiyoneldir ve kullanıcıya sorularak kurulur.
# 
# Güncelleme işi de şu şekilde yapılır. Bazı programlar kendilerini güncelledikleri için script tarafından güncelleme işlemi yapılmaz,
# Bazı programlar ise güncel kullanılması önemli olduğundan, kullanıcıya sorulmadan güncellenir.
# Diğer programlar ise güncelleme yapılmadan önce kullanıcıya sorulur.
#
#############################################################
# Modules
Get-ChildItem -Recurse *.psm1 | Import-Module -Force



Invoke-Expression InstallFonts

