
import * as ___wml from '../../src';


export const template = < A  >(___context:Date < A  > )=>(o:A   )=>(_:string   )=>(__:A  [] )=>(___view:___wml.View)=>___wml.domify(new String (o)) ;;
export class Results< A  > extends ___wml.AppView<Date < A  > > {

    constructor(___context: Date < A  > ) {

        super(___context);

        this.template = (___view:___wml.AppView<Date < A  > >) =>
          ___wml.node('ul', {html : {  } ,wml : {  } }, [___wml.map([1,3,4], function _map(option ,index ) { return ___wml.node('li', {html : {  } ,wml : {  } }, [___wml.domify(option) ,___wml.text(`and`),___wml.domify(index) ], ___view)  }, function otherwise() { return ___wml.node('p', {html : {  } ,wml : {  } }, [___wml.text(`De nada!`)], ___view)  }) ], ___view) ;

       }

     }



