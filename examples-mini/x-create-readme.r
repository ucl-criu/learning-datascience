# x-create-readme.r

### script to create the readme file for the mini examples

# aims to make the examples self-documenting
# i.e. the comments in the files are used to create the documentation
# reduces risk that code & docs diverge
# to work it needs the 2nd non empty line of the scripts to contain the description 
# this script doesn't use the first line of each file - gets name from the filename
# again reduces risk that filenames & docs diverge
# ** later I could add numbering by just adding numbering into filenames e.g. 01-filename.r
# ** that would also make it easy to change order

# uses R to list files, read each mini example and write two lines for each into the readme 
# I might be able to tweak this to add a links to the files, but would only work from github

# list the r files in the folder
filenames <- list.files("examples-mini","*.r")

# first few lines for the reame
text_for_readme <- paste0("# Mini self-contained examples demonstrating coding solutions for patient data\n",
                          "(do not edit: run x-create-readme.r to update)")

# go through each file & create an entry in the readme from the filename
# and the 2nd line of the file

for (i in filenames) {
  
  # cat(i)
  
  # first_lines <- read_lines(paste0('examples-mini/',i), skip_empty_rows=TRUE, n_max=2)
  # text_for_readme <- c(text_for_readme,'\n',first_lines)
  
  
  #use the filename and add ## to make it a markdown heading
  line1 <- paste0("## ",i,"\n")
  
  #extract the 2nd line description from the file  
  line2 <- read_lines(paste0('examples-mini/',i), skip_empty_rows=TRUE, n_max=1, skip=1)
  #remove # comment marks in R that influence markdown formatting
  line2 <- str_remove_all(line2,"#")
  
  # add the entry for this file to that from earlier files
  text_for_readme <- c(text_for_readme,'\n', line1, line2)  
  
}

# write all lines to a markdown file (over-writes by default)
write_lines(text_for_readme, 'examples-mini/readme-examples-mini.md')