Id marceloId = '01MN400000H3YSPMA3';
List<String> codigosClientes = new List<String>{
    '4784', '7101', '7481', '4027', '7294', '4687', '5087', '6714', '6749', '6085',
    '5395', '6868', '6196', '4466', '7434', '5235', '7531', '3938', '3899', '36625',
    '5831', '2831', '3407', '4176', '6815', '4787', '2759', '6751', '7225', '4190',
    '4363', '4202', '2319', '4818', '4220', '5198', '5771', '7485', '7364', '7112',
    '1931', '7271', '7488', '7073', '6495', '7213', '7486', '5061', '5406', '5352',
    '6403', '6534', '5861', '7089', '6350', '6863', '5887', '7025', '7124', '6473',
    '7206', '6909', '7564', '36668', '7604', '7686'
};

List<Account> contas = [
    SELECT Id, Name, ca_codigocliente__c, 
        (SELECT Id, UserId FROM AccountTeamMembers WHERE UserId = :marceloId)
    FROM Account
    WHERE ca_codigocliente__c IN :codigosClientes
];

List<AccountTeamMember> membrosParaRemover = new List<AccountTeamMember>();
for (Account conta : contas) {
    for (AccountTeamMember atm : conta.AccountTeamMembers) {
        membrosParaRemover.add(atm);
    }
}

if (!membrosParaRemover.isEmpty()) {
    delete membrosParaRemover;
    System.debug(':marca_de_verificação_branca: Marcelo foi removido de ' + membrosParaRemover.size() + ' contas.');
} else {
    System.debug(':símbolo_informações: Nenhuma conta com Marcelo para remover.');
}
