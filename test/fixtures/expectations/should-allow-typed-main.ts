
import * as ___wml from '../../src';




export class Something extends ___wml.AppView<Date  > {

    constructor(___context: Date  ) {

        super(___context);

        this.template = (___view:___wml.AppView<Date  >) =>
          ___wml.node('p', {html : {  } ,wml : {  } }, [___wml.domify(___context.toString  ()) ], ___view) ;

       }

     }

