# Procurar e sobrescrever com shell script

Procurar: 'providers'

Inserir abaixo: App\Providers\PermissionsServiceProvider::class, com 8 espaços em branco no início da linha
```php
sr1
sed -i "/.*$1.*/a $2" $3
ins1 "'providers'" "App\Providers\PermissionsServiceProvider::class," app.php

sr18s
sed -i "/.*$1.*/a \        \ $2" $3
ins18s "'providers'" "App\Providers\PermissionsServiceProvider::class," app.php
```

## Inserir três linhas
```php
sed -i "/.*public function run().*/a \ \   \{ \n\        \$this->call(PermissionsSeeder::class);\n\\        \$this->call(ClientsSeeder::class);\n" DatabaseSeeder.php

ins28s
$1 - proc1
$2 - proc2
$3 - ins1
$4 - ins2
$5 - file
sed -i "/.*$1.*/a \ \  \ $2 \n\        \ $3\n\\        \ $4\ $5\n" $6
```
## Usar apóstrofos, aspas simples pois aspas duplas não funcionam

ins28s 'public function run()' '{' '$this->call(PermissionsSeeder::class);' '$this->call(ClientsSeeder::class);' DatabaseSeeder.php

## Apagar duas linhas após $this->call(ClientsSeeder::class);
```php
sed -i '/$this->call(ClientsSeeder::class);/{n;N;d}' DatabaseSeeder.php

del2
$1 - string
$2 - file
sed -i '/$1/{n;N;d}' $2

del2 '$this->call(ClientsSeeder::class);' DatabaseSeeder.php
```php

## Delete a linha contendo o padrão e a próxima
```php
sed '/teste/{N;d;}' DatabaseSeeder.php

delt
sed -i '/$1/{N;d;}' $2
delt 'teste' DatabaseSeeder.php

Para ajustar o DatabaseSeeder.php
ins28s 'public function run()' '{' '$this->call(PermissionsSeeder::class);' '$this->call(ClientsSeeder::class);' DatabaseSeeder.php
del2 '$this->call(ClientsSeeder::class);' DatabaseSeeder.php

sr2
sed -i "/.*$1.*/a $2\n$3" $4

sr28s
sed -i "/.*$1.*/a\        \$2\\n\        \$3" $4
```
