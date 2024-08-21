# Linux: Using sed to insert lines before or after a match

The sed utility is a powerful utility for doing text transformations.  In this article, I will provide an example of how to insert a line before and after a match using sed, which is a common task for customizing configuration files.

I have also written a related article on setting and replacing values in a properties file using sed.

In these examples, we will be dealing with a text file named “text.txt” that contains the following content:
```php
mykey=one
anothervalue=two
lastvalue=three
```
Replace a line when match found

The simplest case is replacing an entire line by finding the line that starts with the match.

Procurar anothervalue= e algo mais a frente

Sobrescrever por replace=me
```php
sed 's/^anothervalue=.*/replace=me/g' test.txt
```
Which produces:
```php
mykey=one
replace=me
lastvalue=three
```
Insert line after match found

Then we have the case where we need to insert a line after the match.

Procurar anothervalue=

E inserir after=me na linha seguinte
```php
sed -i '/^anothervalue=.*/a after=me/g' test.txt

sed -i '/\/\/*.*/a seguinte' teste
```
Which produces:
```php
mykey=one
anothervalue=two
after=me
lastvalue=three
```

Proc e sobres

sed -i 's/old-text/new-text/g' input.txt

Adicionar //laclzz no início da linha que contem 'provider'

sed -i "s/.*'providers'/##zz&/g" app.php

Procurar linhas que em seu início tenha //laclzz

E inserir logo em seguida
```php
sed -i "/.*##zz.*/a 'providers' => [\n\t\tApp\Providers\PermissionsServiceProvider::class," app.php
```

procurar 'providers'

E adicionar abaixo App\Providers\PermissionsServiceProvider::class, com 8 espaços em branco no início da linha
```php
sed -i "/.*'providers'.*/a\        \App\Providers\PermissionsServiceProvider::class," app.php

sr1 $1 $2 $3 $4
$1 - procurar
$2 - sobrescrever1
$3 - sobrescrever2
$4 - arquivo
sed -i "/.*$1.*/a $2\n\t\t$3" $4

$sr2 $1 $2 $3 $4
```

Procurar e sobresvrever a linha com //*
```php
sed -i 's/^anothervalue=.*/replace=me/g' test.txt
```
Insert a line before match found

Then we have the case where we need to insert a line before the match.
```php
sed '/^anothervalue=.*/i before=me' test.txt
```
Which produces:
```php
mykey=one
before=me
anothervalue=two
lastvalue=three
```
Insert multiple lines

And this might have slight variations depending on your POSIX compliance, but if you want to insert multiple lines, you can use ‘\n’ as shown below.
```php
sed '/^anothervalue=.*/i before=me\nbefore2=me2' test.txt
```
Which produces:
```php
mykey=one
before=me
before2=me2
anothervalue=two
lastvalue=three
```

Sed - Insert Text before or after a string in a newline w/o TAB Space

SED is a very powerful utility which allows find and replace/insert text functionality. It should be used with Caution and is recommended to use dry-run before committing the changes. Below are the various commands for text manipulation.

Note: \n = for newline and \t = for TAB space and For dry run just remove "-i" from the command

Find the pattern and Insert text AFTER
```php
# sed -i 's/.*search 1st Line.*/&\nInsert 2nd line/' file1
```
Output:
```php
[root@idm farooq.ahmed]# sed 's/.*search 1st Line.*/&\nInsert 2nd line/' file1
search 1st Line
Insert 2nd line
```
Find the pattern and Insert text AFTER (give TAB space)
```php
# sed -i 's/.*search 1st Line.*/&\n\tInsert 2nd line with TAB Space/' file1
```
Output:
```php

sed 's/.*search 1st Line.*/&\n\tInsert 2nd line with TAB Space/' file1
```
search 1st Line
        Insert 2nd line with TAB Space

Find the pattern and Insert text BEFORE
```php
# sed -i 's/.*search 1st Line.*/Insert 2nd line on top\n&/' file1
```
Output:
```php
sed 's/.*search 1st Line.*/Insert 2nd line on top\n&/' file1
```

Insert 2nd line on top

search 1st Line

Find the pattern and Insert text BEFORE (give TAB space)
```php
# sed -i 's/.*search 1st Line.*/Insert 2nd line on top w TAB Space\n\t&/' file1
```
Output:
```php
sed 's/.*search 1st Line.*/Insert 2nd line on top w TAB Space\n\t&/' file1
```
Insert 2nd line on top w TAB Space
        search 1st Line

https://www.howtovmlinux.com/articles/linux/red-hat-enterprise-linux-centos/sed-insert-text-before-or-after-a-string-in-a-newline-w-o-tab-space.html
```php
sed = test.txt | sed 'N;s/\n/\t/'
```
Apagar as 10 primeiras linhas do arquivo
```php
sed -i '1,10d' teste.php
```
delete lines matching pattern
```php
sed '/pattern/d'
```
Excluir linha que contiver a string
```php
sed -i '/padrao/d' teste.php
```
Adicionar # ao início de cada linha
```php
sed 's/^/#/' file.txt
sed -i 's/^/#/' teste
```
Trocar os caracteres # por um espaço em branco
```php
sed 's/^/ /' file.txt
```
Visualizar uma faixa de linhas de um arquivo
```php
sed -n '5,10p' myfile.txt
```
Ver arquivo inteiro, exceto faixa especificada
```php
sed '20,35d' myfile.txt
```
Sobrescrever
```php
sed 's/version/story/g' myfile.txt

sed -i 's/version/story/g' myfile.txt
```
Ignorando o case
```php
sed 's/version/story/gi' myfile.txt
```
Sobrescrever somente numa faixa de linhas do arquivo
```php
sed '30,40 s/version/story/g' myfile.txt
```
Ver linhas com certo padrão
```php
sed -n '/^Jul  1/ p' /var/log/secure
```
Inserir um espaço em branco em cada linha útil do arquivo
```php
sed G myfile.txt
```
Inserir 2 espaços
```php
sed 'G;G;G;G;G;G;G;G' myfile.txt
```
Duas ou mais substituições ao mesmo tempo
```php
sed -i 's/that/this/gi;s/line/verse/gi' myfile.txt
```
https://www.tecmint.com/linux-sed-command-tips-tricks/

o act on all the non-hidden files in the current directory you could use:
```php
sed -i '1,/pattern/!d' *
```

## REFERENCES

https://www.gnu.org/software/sed/

https://stackoverflow.com/questions/15559359/insert-line-after-first-match-using-sed (insert after match)

https://stackoverflow.com/questions/11694980/using-sed-insert-a-line-below-or-above-the-pattern (insert below match)

fabianlee.org, setting and replacing values in a properties file using sed.

