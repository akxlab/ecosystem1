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

export interface IUserRegistryInterface extends utils.Interface {
  functions: {
    "deRegisterUser()": FunctionFragment;
    "recoverUser()": FunctionFragment;
    "registerUser()": FunctionFragment;
    "resolve()": FunctionFragment;
    "suspendUser(address,bytes32)": FunctionFragment;
    "verifyUser()": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "deRegisterUser"
      | "recoverUser"
      | "registerUser"
      | "resolve"
      | "suspendUser"
      | "verifyUser"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "deRegisterUser",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "recoverUser",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "registerUser",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "resolve", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "suspendUser",
    values: [PromiseOrValue<string>, PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "verifyUser",
    values?: undefined
  ): string;

  decodeFunctionResult(
    functionFragment: "deRegisterUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "recoverUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "registerUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "resolve", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "suspendUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "verifyUser", data: BytesLike): Result;

  events: {
    "UserCreated(address,bytes32)": EventFragment;
    "UserDeleted(address,bytes32)": EventFragment;
    "UserSuspended(address,bytes32)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "UserCreated"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "UserDeleted"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "UserSuspended"): EventFragment;
}

export interface UserCreatedEventObject {
  user: string;
  id: string;
}
export type UserCreatedEvent = TypedEvent<
  [string, string],
  UserCreatedEventObject
>;

export type UserCreatedEventFilter = TypedEventFilter<UserCreatedEvent>;

export interface UserDeletedEventObject {
  user: string;
  id: string;
}
export type UserDeletedEvent = TypedEvent<
  [string, string],
  UserDeletedEventObject
>;

export type UserDeletedEventFilter = TypedEventFilter<UserDeletedEvent>;

export interface UserSuspendedEventObject {
  user: string;
  id: string;
}
export type UserSuspendedEvent = TypedEvent<
  [string, string],
  UserSuspendedEventObject
>;

export type UserSuspendedEventFilter = TypedEventFilter<UserSuspendedEvent>;

export interface IUserRegistry extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: IUserRegistryInterface;

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
    deRegisterUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    recoverUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    registerUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    resolve(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    suspendUser(
      user: PromiseOrValue<string>,
      id: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    verifyUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;
  };

  deRegisterUser(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  recoverUser(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  registerUser(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  resolve(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  suspendUser(
    user: PromiseOrValue<string>,
    id: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  verifyUser(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    deRegisterUser(overrides?: CallOverrides): Promise<void>;

    recoverUser(overrides?: CallOverrides): Promise<void>;

    registerUser(overrides?: CallOverrides): Promise<void>;

    resolve(overrides?: CallOverrides): Promise<void>;

    suspendUser(
      user: PromiseOrValue<string>,
      id: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    verifyUser(overrides?: CallOverrides): Promise<void>;
  };

  filters: {
    "UserCreated(address,bytes32)"(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserCreatedEventFilter;
    UserCreated(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserCreatedEventFilter;

    "UserDeleted(address,bytes32)"(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserDeletedEventFilter;
    UserDeleted(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserDeletedEventFilter;

    "UserSuspended(address,bytes32)"(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserSuspendedEventFilter;
    UserSuspended(
      user?: PromiseOrValue<string> | null,
      id?: null
    ): UserSuspendedEventFilter;
  };

  estimateGas: {
    deRegisterUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    recoverUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    registerUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    resolve(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    suspendUser(
      user: PromiseOrValue<string>,
      id: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    verifyUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    deRegisterUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    recoverUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    registerUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    resolve(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    suspendUser(
      user: PromiseOrValue<string>,
      id: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    verifyUser(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;
  };
}
