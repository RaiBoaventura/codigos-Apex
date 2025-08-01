Id marceloId = '005N400000JDNNH';
List<String> codigosClientes = new List<String>{
    '304','305','2370','454','7150','319','186','1258','2051','3562','2563','326','327','1978',
    '1369','339','3069','2650','6580','5699','1518','365','2247','5808','2402','371','1365',
    '372','2747','3203','1856','2275','2399','3238','3254','1958','390','418','2590','445',
    '2489','2089','5878','2112','460','1247','6537','5911','7333','1503','1808','1973','2554',
    '1908','2604','3315','2718','1329','1920','2874','2674','2799','2942','6245','3205','5940',
    '2049','2328','2271','2214','2389','2318','1214','1620','1902','1463','2696','2748','1850',
    '7399','2055','1970','1264','2663','1457','1619','1852','2210','3486','6686','1367','1408',
    '1806','1857','1939','1975','6457','1507','3240','1497','2139','2129','1322','2776','3514',
    '2961','2025','2132','3408','1312','1323','1485','1689','2408','2423','1268','2042','1549',
    '3725','2303','2289','2207','2556','2316','1465','3173','3501','1483','2015','2026','2437',
    '6690','2092','3243','3272','6997','3224','2585','7332','2354','2495','2764','5686','6045',
    '2773','7074','2882','6128','3206','7391','3273','5813','5802','6016','6321','6358','6452',
    '6056','6129','5975','5762','6363','5992','7414','6613','5673','7221','6218','6012','6046',
    '6015','5886','7127','262425','6939','262599','262610','262633'
};
List<Account> contas = [
    SELECT Id, Name, ca_codigocliente__c, (SELECT Id, UserId FROM AccountTeamMembers)
    FROM Account
    WHERE ca_codigocliente__c IN :codigosClientes
];
List<AccountTeamMember> membrosNovos = new List<AccountTeamMember>();
for (Account conta : contas) {
    Boolean jaTemMarcelo = false;
    for (AccountTeamMember atm : conta.AccountTeamMembers) {
        if (atm.UserId == marceloId) {
            jaTemMarcelo = true;
            break;
        }
    }
    if (!jaTemMarcelo) {
        membrosNovos.add(new AccountTeamMember(
            AccountId = conta.Id,
            UserId = marceloId,
            TeamMemberRole = 'Vendedor TBR',
            AccountAccessLevel = 'Edit',
            OpportunityAccessLevel = 'Edit',
            CaseAccessLevel = 'Edit'
        ));
    }
}
if (!membrosNovos.isEmpty()) {
    insert membrosNovos;
    System.debug(':marca_de_verificação_branca: Marcelo foi adicionado a ' + membrosNovos.size() + ' contas.');
} else {
    System.debug(':símbolo_informações: Nenhuma conta nova para adicionar Marcelo.');
}