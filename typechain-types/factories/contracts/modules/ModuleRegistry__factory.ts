/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../../common";
import type {
  ModuleRegistry,
  ModuleRegistryInterface,
} from "../../../contracts/modules/ModuleRegistry";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "_module",
        type: "address",
      },
    ],
    name: "ModuleDeRegistered",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "_module",
        type: "address",
      },
      {
        indexed: false,
        internalType: "bytes32",
        name: "_name",
        type: "bytes32",
      },
    ],
    name: "ModuleRegistered",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_module",
        type: "address",
      },
    ],
    name: "deregisterModule",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "_name",
        type: "bytes32",
      },
    ],
    name: "getModule",
    outputs: [
      {
        components: [
          {
            internalType: "bytes32",
            name: "name",
            type: "bytes32",
          },
          {
            internalType: "string",
            name: "version",
            type: "string",
          },
          {
            internalType: "bytes32",
            name: "author",
            type: "bytes32",
          },
          {
            internalType: "address",
            name: "contractAddr",
            type: "address",
          },
          {
            internalType: "bytes32",
            name: "mHash",
            type: "bytes32",
          },
        ],
        internalType: "struct IModuleRegistry.Module",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_module",
        type: "address",
      },
    ],
    name: "isRegisteredModuleAddress",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "_name",
        type: "bytes32",
      },
    ],
    name: "isRegisteredModuleName",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_module",
        type: "address",
      },
    ],
    name: "moduleName",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_module",
        type: "address",
      },
      {
        internalType: "string",
        name: "_sName",
        type: "string",
      },
    ],
    name: "registerModule",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b506118b2806100206000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c806352068a931461006757806378b1fa741461009757806385acd641146100b3578063987fc327146100e3578063a94d797814610113578063f355937114610143575b600080fd5b610081600480360381019061007c9190610dbc565b61015f565b60405161008e9190610e04565b60405180910390f35b6100b160048036038101906100ac9190610e7d565b610190565b005b6100cd60048036038101906100c89190610dbc565b610405565b6040516100da9190610fce565b60405180910390f35b6100fd60048036038101906100f89190610e7d565b610538565b60405161010a9190610fff565b60405180910390f35b61012d60048036038101906101289190610e7d565b610581565b60405161013a9190610e04565b60405180910390f35b61015d6004803603810190610158919061114f565b6105de565b005b6000600115156006600084815260200190815260200160002060009054906101000a900460ff161515149050919050565b60008173ffffffffffffffffffffffffffffffffffffffff166393f0899a6040518163ffffffff1660e01b81526004016020604051808303816000875af11580156101df573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061020391906111c0565b905060008082815260200190815260200160002060006101000a81549073ffffffffffffffffffffffffffffffffffffffff02191690556004600082815260200190815260200160002060006101000a81549060ff0219169055600160008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009055600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81549060ff02191690556006600082815260200190815260200160002060006101000a81549060ff02191690556007600082815260200190815260200160002060008082016000905560018201600061033e9190610cc7565b60028201600090556003820160006101000a81549073ffffffffffffffffffffffffffffffffffffffff02191690556004820160009055505060026003600083815260200190815260200160002060405161039991906112f0565b9081526020016040518091039020600090556003600082815260200190815260200160002060006103ca9190610cc7565b7fb292997b2d53de11cc46b82b9a3b1a253cca7aa614fb9b5677cb67d08516f863826040516103f99190611316565b60405180910390a15050565b61040d610d07565b600760008381526020019081526020016000206040518060a0016040529081600082015481526020016001820180546104459061121c565b80601f01602080910402602001604051908101604052809291908181526020018280546104719061121c565b80156104be5780601f10610493576101008083540402835291602001916104be565b820191906000526020600020905b8154815290600101906020018083116104a157829003601f168201915b50505050508152602001600282015481526020016003820160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020016004820154815250509050919050565b6000600160008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050919050565b600060011515600560008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff161515149050919050565b6000816040516020016105f19190611362565b604051602081830303815290604052805190602001209050808373ffffffffffffffffffffffffffffffffffffffff166393f0899a6040518163ffffffff1660e01b81526004016020604051808303816000875af1158015610657573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061067b91906111c0565b146106bb576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016106b2906113d6565b60405180910390fd5b600115153073ffffffffffffffffffffffffffffffffffffffff1663a94d7978856040518263ffffffff1660e01b81526004016106f89190611316565b602060405180830381865afa158015610715573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906107399190611422565b15150361077b576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016107729061149b565b60405180910390fd5b600115153073ffffffffffffffffffffffffffffffffffffffff166352068a93836040518263ffffffff1660e01b81526004016107b89190610fff565b602060405180830381865afa1580156107d5573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906107f99190611422565b15150361083b576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161083290611507565b60405180910390fd5b8260008083815260200190815260200160002060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508060028360405161089d9190611362565b908152602001604051809103902081905550816003600083815260200190815260200160002090816108cf91906116c8565b5060006004600083815260200190815260200160002060006101000a81548160ff02191690831515021790555080600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506001600560008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff02191690831515021790555060016006600083815260200190815260200160002060006101000a81548160ff0219169083151502179055506109cd83610a0b565b7f395917e06309940ec7275c89424ecba05a0c7accd8bdd546e6558c6c86c2523983826040516109fe92919061179a565b60405180910390a1505050565b60008173ffffffffffffffffffffffffffffffffffffffff1663baa3b4d76040518163ffffffff1660e01b81526004016000604051808303816000875af1158015610a5a573d6000803e3d6000fd5b505050506040513d6000823e3d601f19601f82011682018060405250810190610a839190611833565b905060008273ffffffffffffffffffffffffffffffffffffffff16633ea392f36040518163ffffffff1660e01b81526004016020604051808303816000875af1158015610ad4573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610af891906111c0565b905060008373ffffffffffffffffffffffffffffffffffffffff1663488d9f1e6040518163ffffffff1660e01b81526004016020604051808303816000875af1158015610b49573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610b6d91906111c0565b905060006040518060a00160405280600160008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205481526020018581526020018481526020018673ffffffffffffffffffffffffffffffffffffffff1681526020018381525090508060076000600160008973ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020548152602001908152602001600020600082015181600001556020820151816001019081610c6191906116c8565b506040820151816002015560608201518160030160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550608082015181600401559050505050505050565b508054610cd39061121c565b6000825580601f10610ce55750610d04565b601f016020900490600052602060002090810190610d039190610d55565b5b50565b6040518060a00160405280600080191681526020016060815260200160008019168152602001600073ffffffffffffffffffffffffffffffffffffffff168152602001600080191681525090565b5b80821115610d6e576000816000905550600101610d56565b5090565b6000604051905090565b600080fd5b600080fd5b6000819050919050565b610d9981610d86565b8114610da457600080fd5b50565b600081359050610db681610d90565b92915050565b600060208284031215610dd257610dd1610d7c565b5b6000610de084828501610da7565b91505092915050565b60008115159050919050565b610dfe81610de9565b82525050565b6000602082019050610e196000830184610df5565b92915050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000610e4a82610e1f565b9050919050565b610e5a81610e3f565b8114610e6557600080fd5b50565b600081359050610e7781610e51565b92915050565b600060208284031215610e9357610e92610d7c565b5b6000610ea184828501610e68565b91505092915050565b610eb381610d86565b82525050565b600081519050919050565b600082825260208201905092915050565b60005b83811015610ef3578082015181840152602081019050610ed8565b60008484015250505050565b6000601f19601f8301169050919050565b6000610f1b82610eb9565b610f258185610ec4565b9350610f35818560208601610ed5565b610f3e81610eff565b840191505092915050565b610f5281610e3f565b82525050565b600060a083016000830151610f706000860182610eaa565b5060208301518482036020860152610f888282610f10565b9150506040830151610f9d6040860182610eaa565b506060830151610fb06060860182610f49565b506080830151610fc36080860182610eaa565b508091505092915050565b60006020820190508181036000830152610fe88184610f58565b905092915050565b610ff981610d86565b82525050565b60006020820190506110146000830184610ff0565b92915050565b600080fd5b600080fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b61105c82610eff565b810181811067ffffffffffffffff8211171561107b5761107a611024565b5b80604052505050565b600061108e610d72565b905061109a8282611053565b919050565b600067ffffffffffffffff8211156110ba576110b9611024565b5b6110c382610eff565b9050602081019050919050565b82818337600083830152505050565b60006110f26110ed8461109f565b611084565b90508281526020810184848401111561110e5761110d61101f565b5b6111198482856110d0565b509392505050565b600082601f8301126111365761113561101a565b5b81356111468482602086016110df565b91505092915050565b6000806040838503121561116657611165610d7c565b5b600061117485828601610e68565b925050602083013567ffffffffffffffff81111561119557611194610d81565b5b6111a185828601611121565b9150509250929050565b6000815190506111ba81610d90565b92915050565b6000602082840312156111d6576111d5610d7c565b5b60006111e4848285016111ab565b91505092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b6000600282049050600182168061123457607f821691505b602082108103611247576112466111ed565b5b50919050565b600081905092915050565b60008190508160005260206000209050919050565b6000815461127a8161121c565b611284818661124d565b9450600182166000811461129f57600181146112b4576112e7565b60ff19831686528115158202860193506112e7565b6112bd85611258565b60005b838110156112df578154818901526001820191506020810190506112c0565b838801955050505b50505092915050565b60006112fc828461126d565b915081905092915050565b61131081610e3f565b82525050565b600060208201905061132b6000830184611307565b92915050565b600061133c82610eb9565b611346818561124d565b9350611356818560208601610ed5565b80840191505092915050565b600061136e8284611331565b915081905092915050565b600082825260208201905092915050565b7f6e616d6573206d69736d61746368000000000000000000000000000000000000600082015250565b60006113c0600e83611379565b91506113cb8261138a565b602082019050919050565b600060208201905081810360008301526113ef816113b3565b9050919050565b6113ff81610de9565b811461140a57600080fd5b50565b60008151905061141c816113f6565b92915050565b60006020828403121561143857611437610d7c565b5b60006114468482850161140d565b91505092915050565b7f6164647265737320616c72656164792072656769737465726564000000000000600082015250565b6000611485601a83611379565b91506114908261144f565b602082019050919050565b600060208201905081810360008301526114b481611478565b9050919050565b7f6e616d6520616c72656164792072656769737465726564000000000000000000600082015250565b60006114f1601783611379565b91506114fc826114bb565b602082019050919050565b60006020820190508181036000830152611520816114e4565b9050919050565b60006020601f8301049050919050565b600082821b905092915050565b6000600883026115747fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82611537565b61157e8683611537565b95508019841693508086168417925050509392505050565b6000819050919050565b6000819050919050565b60006115c56115c06115bb84611596565b6115a0565b611596565b9050919050565b6000819050919050565b6115df836115aa565b6115f36115eb826115cc565b848454611544565b825550505050565b600090565b6116086115fb565b6116138184846115d6565b505050565b5b818110156116375761162c600082611600565b600181019050611619565b5050565b601f82111561167c5761164d81611258565b61165684611527565b81016020851015611665578190505b61167961167185611527565b830182611618565b50505b505050565b600082821c905092915050565b600061169f60001984600802611681565b1980831691505092915050565b60006116b8838361168e565b9150826002028217905092915050565b6116d182610eb9565b67ffffffffffffffff8111156116ea576116e9611024565b5b6116f4825461121c565b6116ff82828561163b565b600060209050601f8311600181146117325760008415611720578287015190505b61172a85826116ac565b865550611792565b601f19841661174086611258565b60005b8281101561176857848901518255600182019150602085019450602081019050611743565b868310156117855784890151611781601f89168261168e565b8355505b6001600288020188555050505b505050505050565b60006040820190506117af6000830185611307565b6117bc6020830184610ff0565b9392505050565b60006117d66117d18461109f565b611084565b9050828152602081018484840111156117f2576117f161101f565b5b6117fd848285610ed5565b509392505050565b600082601f83011261181a5761181961101a565b5b815161182a8482602086016117c3565b91505092915050565b60006020828403121561184957611848610d7c565b5b600082015167ffffffffffffffff81111561186757611866610d81565b5b61187384828501611805565b9150509291505056fea2646970667358221220b3bc102b86e61388b0e3a227c2946f7b2d10546c26b919fcfc0e32033456cfde64736f6c63430008100033";

type ModuleRegistryConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ModuleRegistryConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ModuleRegistry__factory extends ContractFactory {
  constructor(...args: ModuleRegistryConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ModuleRegistry> {
    return super.deploy(overrides || {}) as Promise<ModuleRegistry>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): ModuleRegistry {
    return super.attach(address) as ModuleRegistry;
  }
  override connect(signer: Signer): ModuleRegistry__factory {
    return super.connect(signer) as ModuleRegistry__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ModuleRegistryInterface {
    return new utils.Interface(_abi) as ModuleRegistryInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ModuleRegistry {
    return new Contract(address, _abi, signerOrProvider) as ModuleRegistry;
  }
}
