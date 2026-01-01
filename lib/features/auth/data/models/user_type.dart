enum UserTypeEnum {
  // DO NOT USE FOR STORAGE OF USER, ONLY FOR ACCESS CHECK
  NOT_LOGGED_IN('0', null, 0),
  // DO NOT USE FOR STORAGE OF USER, ONLY FOR ACCESS CHECK
  ROOT_RESELLER('0', null, 3),
  // DO NOT USE FOR STORAGE OF USER, ONLY FOR ACCESS CHECK
  WHITELABEL_RESELLER('0', null, 3),
  // DO NOT USE FOR STORAGE OF USER, ONLY FOR ACCESS CHECK
  RESELLER_SUB_USER('0', null, 0),
  // DO NOT USE FOR STORAGE OF USER, ONLY FOR ACCESS CHECK
  NON_ROOT_AGENT('0', null, 0),

  /*
     * Agent non-self account user persisted as role A, non-self account user
     */
  STAFF('T', "Staff", 3),

  /*
     * Corporate non-self account user persisted as role C, non-self account
     * user
     */
  EMPLOYEE('E', "Employee", 0),

  WEB('W', "Web", 0),

  AGENT('A', "Agent", 3),

  CORPORATE('C', "Corporate", 4),

  SYSTEM('S', "System", 1),

  DISTRIBUTOR('D', "Distributor", 0),

  SUPPLIER('P', "Supplier", 0),

  REPORTS('R', "Reports", 2);

  final String role;
  final String? type;
  final int level;

  const UserTypeEnum(this.role, this.type, this.level);
}
