local m = {}

m.get_install_path = function(package_name)
    return require("mason-registry").get_package(package_name):get_install_path()
end

return m
