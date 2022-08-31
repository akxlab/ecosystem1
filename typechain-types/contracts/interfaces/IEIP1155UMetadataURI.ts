/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BigNumberish,
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
} from "../../common";

export interface IEIP1155UMetadataURIInterface extends utils.Interface {
  functions: {
    "balanceOf(address,uint256)": FunctionFragment;
    "burn(address,address)": FunctionFragment;
    "isApprovedForAll(address,address)": FunctionFragment;
    "mint(address)": FunctionFragment;
    "recover(address,bytes)": FunctionFragment;
    "safeBatchTransferFrom(address,address,uint256[],bytes)": FunctionFragment;
    "safeTransferFrom(address,address,uint256,bytes)": FunctionFragment;
    "setApprovalForAll(address,bool)": FunctionFragment;
    "uri(uint256)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "balanceOf"
      | "burn"
      | "isApprovedForAll"
      | "mint"
      | "recover"
      | "safeBatchTransferFrom"
      | "safeTransferFrom"
      | "setApprovalForAll"
      | "uri"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "balanceOf",
    values: [PromiseOrValue<string>, PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "burn",
    values: [PromiseOrValue<string>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "isApprovedForAll",
    values: [PromiseOrValue<string>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "mint",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "recover",
    values: [PromiseOrValue<string>, PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "safeBatchTransferFrom",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>[],
      PromiseOrValue<BytesLike>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "safeTransferFrom",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BytesLike>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "setApprovalForAll",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "uri",
    values: [PromiseOrValue<BigNumberish>]
  ): string;

  decodeFunctionResult(functionFragment: "balanceOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "burn", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "isApprovedForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "mint", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "recover", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "safeBatchTransferFrom",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "safeTransferFrom",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setApprovalForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "uri", data: BytesLike): Result;

  events: {
    "ApprovalForAll(address,address,bool)": EventFragment;
    "TransferBatch(address,address,address,uint256[])": EventFragment;
    "TransferSingle(address,address,address,uint256)": EventFragment;
    "URI(string,uint256)": EventFragment;
    "UserBurned(address,bytes32)": EventFragment;
    "UserMinted(address,address,bytes32)": EventFragment;
    "UserRecovered(address,address,bytes32)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "ApprovalForAll"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "TransferBatch"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "TransferSingle"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "URI"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "UserBurned"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "UserMinted"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "UserRecovered"): EventFragment;
}

export interface ApprovalForAllEventObject {
  _owner: string;
  _operator: string;
  _approved: boolean;
}
export type ApprovalForAllEvent = TypedEvent<
  [string, string, boolean],
  ApprovalForAllEventObject
>;

export type ApprovalForAllEventFilter = TypedEventFilter<ApprovalForAllEvent>;

export interface TransferBatchEventObject {
  _operator: string;
  _from: string;
  _to: string;
  _ids: BigNumber[];
}
export type TransferBatchEvent = TypedEvent<
  [string, string, string, BigNumber[]],
  TransferBatchEventObject
>;

export type TransferBatchEventFilter = TypedEventFilter<TransferBatchEvent>;

export interface TransferSingleEventObject {
  _operator: string;
  _from: string;
  _to: string;
  _id: BigNumber;
}
export type TransferSingleEvent = TypedEvent<
  [string, string, string, BigNumber],
  TransferSingleEventObject
>;

export type TransferSingleEventFilter = TypedEventFilter<TransferSingleEvent>;

export interface URIEventObject {
  _value: string;
  _id: BigNumber;
}
export type URIEvent = TypedEvent<[string, BigNumber], URIEventObject>;

export type URIEventFilter = TypedEventFilter<URIEvent>;

export interface UserBurnedEventObject {
  operator: string;
  id: string;
}
export type UserBurnedEvent = TypedEvent<
  [string, string],
  UserBurnedEventObject
>;

export type UserBurnedEventFilter = TypedEventFilter<UserBurnedEvent>;

export interface UserMintedEventObject {
  operator: string;
  owner: string;
  id: string;
}
export type UserMintedEvent = TypedEvent<
  [string, string, string],
  UserMintedEventObject
>;

export type UserMintedEventFilter = TypedEventFilter<UserMintedEvent>;

export interface UserRecoveredEventObject {
  operator: string;
  by: string;
  id: string;
}
export type UserRecoveredEvent = TypedEvent<
  [string, string, string],
  UserRecoveredEventObject
>;

export type UserRecoveredEventFilter = TypedEventFilter<UserRecoveredEvent>;

export interface IEIP1155UMetadataURI extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: IEIP1155UMetadataURIInterface;

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
    balanceOf(
      _owner: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    burn(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    isApprovedForAll(
      _owner: PromiseOrValue<string>,
      _operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    mint(
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    recover(
      _from: PromiseOrValue<string>,
      _recoveryData: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    safeBatchTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _ids: PromiseOrValue<BigNumberish>[],
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    safeTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setApprovalForAll(
      _operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    uri(
      id: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string]>;
  };

  balanceOf(
    _owner: PromiseOrValue<string>,
    _id: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  burn(
    _from: PromiseOrValue<string>,
    _to: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  isApprovedForAll(
    _owner: PromiseOrValue<string>,
    _operator: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  mint(
    _to: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  recover(
    _from: PromiseOrValue<string>,
    _recoveryData: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  safeBatchTransferFrom(
    _from: PromiseOrValue<string>,
    _to: PromiseOrValue<string>,
    _ids: PromiseOrValue<BigNumberish>[],
    _data: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  safeTransferFrom(
    _from: PromiseOrValue<string>,
    _to: PromiseOrValue<string>,
    _id: PromiseOrValue<BigNumberish>,
    _data: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setApprovalForAll(
    _operator: PromiseOrValue<string>,
    _approved: PromiseOrValue<boolean>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  uri(
    id: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string>;

  callStatic: {
    balanceOf(
      _owner: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    burn(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isApprovedForAll(
      _owner: PromiseOrValue<string>,
      _operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    mint(
      _to: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    recover(
      _from: PromiseOrValue<string>,
      _recoveryData: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    safeBatchTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _ids: PromiseOrValue<BigNumberish>[],
      _data: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    safeTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      _data: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    setApprovalForAll(
      _operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<void>;

    uri(
      id: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;
  };

  filters: {
    "ApprovalForAll(address,address,bool)"(
      _owner?: PromiseOrValue<string> | null,
      _operator?: PromiseOrValue<string> | null,
      _approved?: null
    ): ApprovalForAllEventFilter;
    ApprovalForAll(
      _owner?: PromiseOrValue<string> | null,
      _operator?: PromiseOrValue<string> | null,
      _approved?: null
    ): ApprovalForAllEventFilter;

    "TransferBatch(address,address,address,uint256[])"(
      _operator?: PromiseOrValue<string> | null,
      _from?: PromiseOrValue<string> | null,
      _to?: PromiseOrValue<string> | null,
      _ids?: null
    ): TransferBatchEventFilter;
    TransferBatch(
      _operator?: PromiseOrValue<string> | null,
      _from?: PromiseOrValue<string> | null,
      _to?: PromiseOrValue<string> | null,
      _ids?: null
    ): TransferBatchEventFilter;

    "TransferSingle(address,address,address,uint256)"(
      _operator?: PromiseOrValue<string> | null,
      _from?: PromiseOrValue<string> | null,
      _to?: PromiseOrValue<string> | null,
      _id?: null
    ): TransferSingleEventFilter;
    TransferSingle(
      _operator?: PromiseOrValue<string> | null,
      _from?: PromiseOrValue<string> | null,
      _to?: PromiseOrValue<string> | null,
      _id?: null
    ): TransferSingleEventFilter;

    "URI(string,uint256)"(
      _value?: null,
      _id?: PromiseOrValue<BigNumberish> | null
    ): URIEventFilter;
    URI(
      _value?: null,
      _id?: PromiseOrValue<BigNumberish> | null
    ): URIEventFilter;

    "UserBurned(address,bytes32)"(
      operator?: PromiseOrValue<string> | null,
      id?: null
    ): UserBurnedEventFilter;
    UserBurned(
      operator?: PromiseOrValue<string> | null,
      id?: null
    ): UserBurnedEventFilter;

    "UserMinted(address,address,bytes32)"(
      operator?: PromiseOrValue<string> | null,
      owner?: PromiseOrValue<string> | null,
      id?: null
    ): UserMintedEventFilter;
    UserMinted(
      operator?: PromiseOrValue<string> | null,
      owner?: PromiseOrValue<string> | null,
      id?: null
    ): UserMintedEventFilter;

    "UserRecovered(address,address,bytes32)"(
      operator?: PromiseOrValue<string> | null,
      by?: PromiseOrValue<string> | null,
      id?: null
    ): UserRecoveredEventFilter;
    UserRecovered(
      operator?: PromiseOrValue<string> | null,
      by?: PromiseOrValue<string> | null,
      id?: null
    ): UserRecoveredEventFilter;
  };

  estimateGas: {
    balanceOf(
      _owner: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    burn(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    isApprovedForAll(
      _owner: PromiseOrValue<string>,
      _operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    mint(
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    recover(
      _from: PromiseOrValue<string>,
      _recoveryData: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    safeBatchTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _ids: PromiseOrValue<BigNumberish>[],
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    safeTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setApprovalForAll(
      _operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    uri(
      id: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    balanceOf(
      _owner: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    burn(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    isApprovedForAll(
      _owner: PromiseOrValue<string>,
      _operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    mint(
      _to: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    recover(
      _from: PromiseOrValue<string>,
      _recoveryData: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    safeBatchTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _ids: PromiseOrValue<BigNumberish>[],
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    safeTransferFrom(
      _from: PromiseOrValue<string>,
      _to: PromiseOrValue<string>,
      _id: PromiseOrValue<BigNumberish>,
      _data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setApprovalForAll(
      _operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    uri(
      id: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}
