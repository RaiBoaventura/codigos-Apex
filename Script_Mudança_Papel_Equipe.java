// Trocar "Vendedor TBR" -> "Vendedor PCR" para o usuário informado, em TODAS as contas
Id targetUserId = '005be000007ii53AAA';
// 1) Busque todos os membros de equipe do usuário cujo papel contenha "TBR"
List<AccountTeamMember> rows = [
    SELECT Id, AccountId, UserId, TeamMemberRole
    FROM AccountTeamMember
    WHERE UserId = :targetUserId
      AND TeamMemberRole LIKE '%TBR%'   // tolerante a variações (case-insensitive)
];
// 2) Prepare atualização
for (AccountTeamMember r : rows) {
    r.TeamMemberRole = 'Vendedor PCR';
}
// 3) Atualize com tolerância a erro e log
if (!rows.isEmpty()) {
    Integer ok = 0, nok = 0;
    Database.SaveResult[] results = Database.update(rows, /*allOrNone*/ false);
    for (Integer i = 0; i < results.size(); i++) {
        if (results[i].isSuccess()) ok++;
        else {
            nok++;
            for (Database.Error e : results[i].getErrors()) {
                System.debug(':x_vermelho: Falha em ' + rows[i].Id + ' (Acct ' + rows[i].AccountId + '): '
                             + e.getStatusCode() + ' - ' + e.getMessage());
            }
        }
    }
    System.debug(':marca_de_verificação_branca: Atualizados: ' + ok + ' | :x_vermelho: Falhas: ' + nok);
} else {
    System.debug(':atenção: Nenhum registro com papel contendo "TBR" para esse usuário.');
}