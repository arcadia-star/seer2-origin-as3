package seer2.next.entry {
public class NextEntry {
    public function NextEntry() {
    }

    public static function initialize() : void
    {
        UrlRewriter.loadConfig();
        ReloadConfig.loadConfig();
        MoneyMaker.makeMoney();
    }
}
}
