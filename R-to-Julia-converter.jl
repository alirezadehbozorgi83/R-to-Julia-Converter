using Pkg

# Install the Pandoc package
Pkg.add("Pandoc")

# Import the Pandoc package
using Pandoc

# Define a function to convert R and Rmd files to Julia
function convert_R_to_Julia(file_path::String)
    # Read in the R or Rmd file using Pandoc
    input = pandoc(file_path)

    # Define the output file path with .jl file extension
    output_file_path = replace(file_path, r"\.[RrRmd]+$" => ".jl")

    # Write the Julia code to the output file
    open(output_file_path, "w") do f
        write(f, input)
    end
end

# Define a function to convert all R and Rmd files in a folder and its subfolders to Julia
function convert_all_files_to_Julia(folder_path::String)
    for item in readdir(folder_path)
        # Define the full path of the current directory item
        item_path = joinpath(folder_path, item)

        # Check if the item in the folder is a directory, and if so, recursively call the function
        if isdir(item_path)
            convert_all_files_to_Julia(item_path)
        else
            # If the file extension is .R or .Rmd, convert it to Julia
            if endswith(item, ".R") || endswith(item, ".Rmd")
                convert_R_to_Julia(item_path)
            end
        end
    end
end


convert_all_files_to_Julia()

# Call the function to convert all R and Rmd files in the specified folder and its subfolders
convert_all_files_to_Julia("path/to/folder")

