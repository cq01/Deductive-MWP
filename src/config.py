
import torch

from enum import Enum

class Config:
    def __init__(self, args) -> None:

        # data hyperparameter
        self.batch_size = args.batch_size
        self.train_num = args.train_num
        self.dev_num = args.dev_num
        self.test_num = args.test_num

        self.num_workers = 8 ## workers

        # optimizer hyperparameter
        self.learning_rate = args.learning_rate
        self.max_grad_norm = args.max_grad_norm

        # training
        self.device = torch.device(args.device)
        self.num_epochs = args.num_epochs
        self.fp16 = args.fp16

        # model
        self.model_folder = args.model_folder
        self.bert_model_name = args.bert_model_name
        self.bert_folder = args.bert_folder
        self.height = args.height
        self.var_update_mode = args.var_update_mode


        self.train_file = args.train_file
        self.dev_file = args.dev_file
        self.test_file = args.test_file


        self.uni_labels = []