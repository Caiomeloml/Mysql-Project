**Campos Numéricos**
Alguns campos numéricos possuem a opção UNSIGNED. Isso quer dizer que o número não pode ser negativo. Por exemplo: o campo TINYINT com a opção UNSIGNED vai de 0 até 255, sem a opção UNSIGNED vai de -128 até 127.

A opção ZEROFILL completa o campo com zeros. Por exemplo: se você cadastrar ’65’ em um campo INT(5) – ou seja, inteiro com 5 dígitos – com a opção ZEROFILL habilitada, o MySQL irá cadastrar ‘00065’. Sem a opção ZEROFILL habilitada, o MySQL irá cadastrar ’65’.

- TINYINT: Um número muito pequeno, de 0 até 255 (UNSIGNED) ou -128 até 127. Ocupa 1 byte.
- SMALLINT: Um inteiro pequeno, de 0 a 65535 (UNSIGNED) ou -32768 até 32767. Ocupa 2 bytes.
- MEDIUMINT: Um inteiro de tamanho médio, de 0 a 16777215 (UNSIGNED) ou -8388608 a 8388607. Ocupa 3 bytes.
- INT ou INTEGER: Um inteiro de tamanho normal. De 0 a 4294967295 (UNSIGNED) ou -2147483648 a 2147483647. Ocupa 4 bytes.
- BIGINT: Um inteiro grande. De 0 a 18446744073709551615 ou -9223372036854775808 a 9223372036854775807. Ocupa 8 bytes.
- DECIMAL: Um número decimal. Para armazenar um valor monetário, por exemplo, você pode definir o tamanho dele como 8,2. Isso quer dizer que ele poderá ter 8 dígitos à esquerda da vírgula, e duas casas decimais à direita da vírgula. O campo é armazenado como string, então não deve ocorrer nenhuma perda de precisão (arredondamento).
- DATE: Data no formato ‘AAAA-MM-DD’. Entre ‘1000-01-01’ e ‘9999-12-31’.
- DATETIME: Combinação de data e hora no formato ‘AAAA-MM-DD HH:MM:SS’. Entre ‘1000-01-01 00:00:00’ e ‘9999-12-31 23:59:59’.
- TIME: Hora no formato ‘HH:MM:SS’. A faixa é entre ‘-838:59:59’ e ‘838:59:59’.
- YEAR: Ano com 2 ou 4 dígitos (padrão 4 dígitos).
- ENUM: Uma enumeração. Exemplo de uso: você tem um campo chamado “ativo” que possui apenas duas opções (0 e 1). Pode ter até 65535 valores diferentes.

**Campos String (texto)**

- VARCHAR: String com tamanho entre 1 e 255 caracteres.
- CHAR: String com tamanho entre 1 e 255 caracteres. Para campos com tamanho fixo (CPF, CEP etc.) é mais vantagem usar o CHAR, porque ele ocupa um byte a menos que o VARCHAR. Por exemplo: você vai cadastrar o valor “abcde” em um campo CHAR(5), ele vai ocupar 5 bytes, se você cadastrar em um VARCHAR(5), ele vai ocupar 6 bytes, porém se você cadastrar o valor “ab” em um campo CHAR(5) ele vai ocupar os mesmos 5 bytes, e o VARCHAR(5) vai ocupar 3 bytes (1 byte a mais do que a quantidade de caracteres).
- TINYTEXT ou TINYBLOB: String com até 255 bytes.
- TEXT ou BLOB: String com até 65535 bytes ou 64KB.
- MEDIUMTEXT ou MEDIUMBLOB: String com até 16777215 bytes ou 16MB.
- LONGBLOB: String com até 4294967295 bytes ou (4GB).