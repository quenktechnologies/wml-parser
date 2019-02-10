
import * as ___wml from '../../src';


export class Main extends ___wml.AppView<Context < String  > > {

    constructor(___context: Context < String  > ) {

        super(___context);

        this.template = (___view:___wml.AppView<Context < String  > >) =>
          ___wml.node('p', {html : {  } ,wml : {  } }, [___wml.domify(___context.value) ], ___view) ;

       }

     }



