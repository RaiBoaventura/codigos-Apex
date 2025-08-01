// ID do usuário Cristiano Antunes Lassance Guimaraes
Id usuarioId = '005N4000007uwN5';
// Buscar todos os registros de AccountTeamMember com esse usuário
List<AccountTeamMember> membros = [
    SELECT Id, AccountId, TeamMemberRole
    FROM AccountTeamMember
    WHERE UserId = :usuarioId
];
System.debug('Total de contas com esse vendedor: ' + membros.size());
// Remover os registros
if (!membros.isEmpty()) {
    delete membros;
    System.debug('Membro Cristiano removido com sucesso de todas as contas.');
} else {
    System.debug('Nenhum vínculo de conta encontrado para Cristiano.');
}