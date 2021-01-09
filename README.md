# html-dir-lists
Create bare-bones HTML pages to make your directories browsable. 

This script, `buildDirListings.sh`, creates a bare-bones directory listing page 
for each of the children of the current directory.
To avoid unintentionally exposing filepaths, 
the directory listing does not include a link to the parent, and it only creates pages for children, not grandchildren or great-grandchildren. 

This script is idempotent, which means that you can run it repeatedly without changing the result. It also handles most special characters that might be in filenames. 

# Before using
Before running this script, consider using your server's built-in directory listing feature. On Apache, you can enable directory listing by adding `Options +Indexes` to the .htaccess file. If that's not an option for you (pun not intended), read on. 

# Demo
Imagine you have a directory - let's call it `example` - with some stuff in it. You want to be able to give someone a link to any of its subdirectories, like `https://abc.com/example/exampleDir`, which will let them browse the contents of that subdirectory. 

First, go into the example directory:

```sh
cd example
```

Then, run the script:

```sh
bash ../buildDirListings.sh
```

Ta-da! Now there is an `index.html` page inside each of `exampleDir` and `exampleDir2`. 

If you like, you can download this repository, delete the `index.html` files, and then run the commands above to re-create them. 