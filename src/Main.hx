package;

import tools.Dispatcher;
import tools.NativeJS;

class Main
{
    static public function main() {
        trace(new Dispatcher());
        trace(NativeJS.jsonRead("{}"));
    }
}