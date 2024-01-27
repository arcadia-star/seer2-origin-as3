package seer2.next.entry {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class MoneyMaker {


    public function MoneyMaker() {
        super();
    }

    public static function makeMoney():void {
        makeMoney1(null);
    }

    public static function makeMoney1(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney1);
        Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney1Error);
        Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney1);
        Connection.addErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney1Error);
        Connection.send(CommandSet.ITEM_EXCHANGE_1055, 2772, 1, 0);
    }

    public static function makeMoney1Error(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney1);
        Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney1Error);
        makeMoney2(null);
    }

    public static function makeMoney2(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney2);
        Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney2Error);
        Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney2);
        Connection.addErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney2Error);
        Connection.send(CommandSet.ITEM_EXCHANGE_1055, 2848, 1, 1, 1);
    }

    public static function makeMoney2Error(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, makeMoney2);
        Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055, makeMoney2Error);
    }
}
}
