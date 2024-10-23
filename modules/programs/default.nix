# A module that automatically imports everything else in the parent folder.
# {
#   imports =
#     with builtins;
#     map
#       (fn: ./${fn})
#       (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
# }
{ lib, ... }:
let
  # Function to recursively find .nix files
  findModules = dir:
    with builtins;
    let
      # Read the contents of the directory
      dirContents = readDir dir;

      # Helper function to handle subdirectories
      handleEntry = name: type:
        if type == "directory"
        then findModules "${dir}/${name}" # Recurse into subdirectories
        else if lib.hasSuffix ".nix" name && !(lib.hasPrefix "_" name) && name != "default.nix"
        then [ "${dir}/${name}" ] # Include .nix files that don't start with underscore and aren't default.nix
        else [ ]; # Ignore other files

      # Process each item in the directory
      processedFiles = lib.mapAttrsToList handleEntry dirContents;
    in
    # Flatten the list of files
    lib.flatten processedFiles;

  # Get all module files
  moduleFiles = findModules ./.;

in
{
  # Import all found modules
  imports = moduleFiles;
}
