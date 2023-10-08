package MEncrypt
{
   public const ram_init:ByteArray = (!!workerClass ? workerClass.current.getSharedProperty("flascc.ram") : null) || (!!domainClass.currentDomain.domainMemory ? domainClass.currentDomain.domainMemory : new ByteArray());
}
