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
} from "../../common";

export declare namespace IModuleRegistry {
  export type ModuleStruct = {
    name: PromiseOrValue<BytesLike>;
    version: PromiseOrValue<string>;
    author: PromiseOrValue<BytesLike>;
    contractAddr: PromiseOrValue<string>;
    mHash: PromiseOrValue<BytesLike>;
  };

  export type ModuleStructOutput = [string, string, string, string, string] & {
    name: string;
    version: string;
    author: string;
    contractAddr: string;
    mHash: string;
  };
}

export interface ModuleRegistryInterface extends utils.Interface {
  functions: {
    "getModule(bytes32)": FunctionFragment;
    "isRegisteredModuleAddress(address)": FunctionFragment;
    "isRegisteredModuleName(bytes32)": FunctionFragment;
    "moduleAuthor()": FunctionFragment;
    "moduleContract()": FunctionFragment;
    "moduleHash()": FunctionFragment;
    "moduleName(address)": FunctionFragment;
    "moduleVersion()": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "getModule"
      | "isRegisteredModuleAddress"
      | "isRegisteredModuleName"
      | "moduleAuthor"
      | "moduleContract"
      | "moduleHash"
      | "moduleName"
      | "moduleVersion"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "getModule",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "isRegisteredModuleAddress",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "isRegisteredModuleName",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "moduleAuthor",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "moduleContract",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "moduleHash",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "moduleName",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "moduleVersion",
    values?: undefined
  ): string;

  decodeFunctionResult(functionFragment: "getModule", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "isRegisteredModuleAddress",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isRegisteredModuleName",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "moduleAuthor",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "moduleContract",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "moduleHash", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "moduleName", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "moduleVersion",
    data: BytesLike
  ): Result;

  events: {
    "ModuleAdded(bytes32)": EventFragment;
    "ModuleDeRegistered(address)": EventFragment;
    "ModuleRegistered(address,bytes32)": EventFragment;
    "ModuleRemoved(bytes32)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "ModuleAdded"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ModuleDeRegistered"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ModuleRegistered"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ModuleRemoved"): EventFragment;
}

export interface ModuleAddedEventObject {
  _name: string;
}
export type ModuleAddedEvent = TypedEvent<[string], ModuleAddedEventObject>;

export type ModuleAddedEventFilter = TypedEventFilter<ModuleAddedEvent>;

export interface ModuleDeRegisteredEventObject {
  _module: string;
}
export type ModuleDeRegisteredEvent = TypedEvent<
  [string],
  ModuleDeRegisteredEventObject
>;

export type ModuleDeRegisteredEventFilter =
  TypedEventFilter<ModuleDeRegisteredEvent>;

export interface ModuleRegisteredEventObject {
  _module: string;
  _name: string;
}
export type ModuleRegisteredEvent = TypedEvent<
  [string, string],
  ModuleRegisteredEventObject
>;

export type ModuleRegisteredEventFilter =
  TypedEventFilter<ModuleRegisteredEvent>;

export interface ModuleRemovedEventObject {
  _name: string;
}
export type ModuleRemovedEvent = TypedEvent<[string], ModuleRemovedEventObject>;

export type ModuleRemovedEventFilter = TypedEventFilter<ModuleRemovedEvent>;

export interface ModuleRegistry extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: ModuleRegistryInterface;

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
    getModule(
      _name: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    isRegisteredModuleAddress(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    isRegisteredModuleName(
      _name: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    moduleAuthor(overrides?: CallOverrides): Promise<[string]>;

    moduleContract(overrides?: CallOverrides): Promise<[string]>;

    moduleHash(overrides?: CallOverrides): Promise<[string]>;

    moduleName(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[BigNumber]>;

    moduleVersion(overrides?: CallOverrides): Promise<[string]>;
  };

  getModule(
    _name: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  isRegisteredModuleAddress(
    _module: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  isRegisteredModuleName(
    _name: PromiseOrValue<BytesLike>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  moduleAuthor(overrides?: CallOverrides): Promise<string>;

  moduleContract(overrides?: CallOverrides): Promise<string>;

  moduleHash(overrides?: CallOverrides): Promise<string>;

  moduleName(
    _module: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  moduleVersion(overrides?: CallOverrides): Promise<string>;

  callStatic: {
    getModule(
      _name: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<IModuleRegistry.ModuleStructOutput>;

    isRegisteredModuleAddress(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    isRegisteredModuleName(
      _name: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    moduleAuthor(overrides?: CallOverrides): Promise<string>;

    moduleContract(overrides?: CallOverrides): Promise<string>;

    moduleHash(overrides?: CallOverrides): Promise<string>;

    moduleName(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    moduleVersion(overrides?: CallOverrides): Promise<string>;
  };

  filters: {
    "ModuleAdded(bytes32)"(_name?: null): ModuleAddedEventFilter;
    ModuleAdded(_name?: null): ModuleAddedEventFilter;

    "ModuleDeRegistered(address)"(
      _module?: null
    ): ModuleDeRegisteredEventFilter;
    ModuleDeRegistered(_module?: null): ModuleDeRegisteredEventFilter;

    "ModuleRegistered(address,bytes32)"(
      _module?: null,
      _name?: null
    ): ModuleRegisteredEventFilter;
    ModuleRegistered(_module?: null, _name?: null): ModuleRegisteredEventFilter;

    "ModuleRemoved(bytes32)"(_name?: null): ModuleRemovedEventFilter;
    ModuleRemoved(_name?: null): ModuleRemovedEventFilter;
  };

  estimateGas: {
    getModule(
      _name: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    isRegisteredModuleAddress(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isRegisteredModuleName(
      _name: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    moduleAuthor(overrides?: CallOverrides): Promise<BigNumber>;

    moduleContract(overrides?: CallOverrides): Promise<BigNumber>;

    moduleHash(overrides?: CallOverrides): Promise<BigNumber>;

    moduleName(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    moduleVersion(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    getModule(
      _name: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    isRegisteredModuleAddress(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isRegisteredModuleName(
      _name: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    moduleAuthor(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    moduleContract(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    moduleHash(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    moduleName(
      _module: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    moduleVersion(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}
