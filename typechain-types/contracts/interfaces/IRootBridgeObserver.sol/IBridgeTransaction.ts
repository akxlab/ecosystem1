/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import type {
  FunctionFragment,
  Result,
  EventFragment,
} from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "../../../common";

export interface IBridgeTransactionInterface extends utils.Interface {
  functions: {
    "getMessageHash(bytes)": FunctionFragment;
    "signMessage(bytes)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic: "getMessageHash" | "signMessage"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "getMessageHash",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "signMessage",
    values: [PromiseOrValue<BytesLike>]
  ): string;

  decodeFunctionResult(
    functionFragment: "getMessageHash",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "signMessage",
    data: BytesLike
  ): Result;

  events: {
    "BridgeSignedMessage(bytes32)": EventFragment;
    "SendBridgeCurrencyTransaction(address,uint256,address,bytes,uint256,uint256)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "BridgeSignedMessage"): EventFragment;
  getEvent(
    nameOrSignatureOrTopic: "SendBridgeCurrencyTransaction"
  ): EventFragment;
}

export interface BridgeSignedMessageEventObject {
  msgHash: string;
}
export type BridgeSignedMessageEvent = TypedEvent<
  [string],
  BridgeSignedMessageEventObject
>;

export type BridgeSignedMessageEventFilter =
  TypedEventFilter<BridgeSignedMessageEvent>;

export interface SendBridgeCurrencyTransactionEventObject {
  from: string;
  chainId: BigNumber;
  target: string;
  message: string;
  fees: BigNumber;
  amount: BigNumber;
}
export type SendBridgeCurrencyTransactionEvent = TypedEvent<
  [string, BigNumber, string, string, BigNumber, BigNumber],
  SendBridgeCurrencyTransactionEventObject
>;

export type SendBridgeCurrencyTransactionEventFilter =
  TypedEventFilter<SendBridgeCurrencyTransactionEvent>;

export interface IBridgeTransaction extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: IBridgeTransactionInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    getMessageHash(
      message: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<[string]>;

    signMessage(
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;
  };

  getMessageHash(
    message: PromiseOrValue<BytesLike>,
    overrides?: CallOverrides
  ): Promise<string>;

  signMessage(
    _data: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    getMessageHash(
      message: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<string>;

    signMessage(
      _data: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {
    "BridgeSignedMessage(bytes32)"(
      msgHash?: PromiseOrValue<BytesLike> | null
    ): BridgeSignedMessageEventFilter;
    BridgeSignedMessage(
      msgHash?: PromiseOrValue<BytesLike> | null
    ): BridgeSignedMessageEventFilter;

    "SendBridgeCurrencyTransaction(address,uint256,address,bytes,uint256,uint256)"(
      from?: null,
      chainId?: null,
      target?: null,
      message?: null,
      fees?: null,
      amount?: null
    ): SendBridgeCurrencyTransactionEventFilter;
    SendBridgeCurrencyTransaction(
      from?: null,
      chainId?: null,
      target?: null,
      message?: null,
      fees?: null,
      amount?: null
    ): SendBridgeCurrencyTransactionEventFilter;
  };

  estimateGas: {
    getMessageHash(
      message: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    signMessage(
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    getMessageHash(
      message: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    signMessage(
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;
  };
}