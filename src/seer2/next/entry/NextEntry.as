package seer2.next.entry {
import seer2.next.fight.ui.FightUI;

public class NextEntry {
    public function NextEntry() {
    }

    public static function initialize():void {
        UrlRewriter.loadConfig(function ():void {
            FightUI.clazz;
        });
        MoneyMaker.makeMoney();

    }

    /**
     * 已通过鉴权，登录成功，尚未加载UI
     */
    public static function afterLoginSuccess(cb:Function):void {
        cb();
    }
}
}
